#!/bin/bash

# This script will stream a youtube video to mpv using yt-dlp.
# Usage: ytPlayer.sh <youtube video url>

# Set working directory
workDir="/workspace/playYoutubeFromPi/"
cd $workDir

# python3 -m venv venv
# source venv/bin/activate
# pip3 install -r requirements.txt

# Path to the cookies file
cookiePath="/workspace/playYoutubeFromPi/cookies.txt"

# Check if yt-dlp is installed
yt_dlp="$workDir/venv/yt-dlp"
if ! command -v $yt_dlp &>/dev/null; then
	echo "yt-dlp could not be found. Please install it."
	mkdir -p $workDir/venv
	wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -O $yt_dlp
	chmod a+x $yt_dlp
fi

# Check if mpv is installed
if ! command -v mpv &>/dev/null; then
	echo "mpv could not be found. Please install it."
	sudo apt install mpv
fi

# some default options for mpv
mpvOptions="--fs --no-ytdl "

url=""
if [ -p /dev/stdin ]; then
	url=$(cat)
else
	url=$1
fi

# if url empty
if [ -z "$url" ]; then
	echo "No video url input. Get the video list from the Youtube."
	# $yt_dlp --cookies "$cookiePath" --lazy-playlist --flat-playlist --playlist-end 20 --skip-download --print "%(original_url)s;%(title)s;%(uploader)s" "https://www.youtube.com/"

	urlListStr=$($yt_dlp --cookies "$cookiePath" --lazy-playlist --flat-playlist --playlist-end 20 --skip-download --print "%(original_url)s;%(title)s;%(uploader)s" "https://www.youtube.com/")

	dataLineList=()
	while IFS= read -r line; do
		dataLineList+=("$line")
	done <<<"$urlListStr"

	urlList=()
	for item in "${dataLineList[@]}"; do
		IFS=';' read -r -a data <<<"$item"
		urlList+=("${data[0]}")
		echo idx: ${#urlList[@]} - ${data[1]} - ${data[2]}
	done

	# Ask user to select the video
	echo "Enter the video index:"
	read idx
	url=${urlList[$idx - 1]}
	echo "Selected video: $url"
fi

# Ask user select subtitles
echo "Do you want to enable subtitles? (y/n) Default: n"
read subtitles

if [ "$subtitles" = "y" ]; then
	$yt_dlp --list-subs "$url"
	echo "Enter the subtitle code:"
	read code
	# Only Download the subtitles to /tmp
	randomName="$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)"
	$yt_dlp --cookies "$cookiePath" --write-auto-subs --write-subs --sub-langs $code -o "/tmp/$randomName.srt" --skip-download "$url"
	subPath="/tmp/$randomName.srt.$code.vtt"
	echo "Subtitles be saved to $subPath"
	mpvOptions+=--sub-file="$subPath"
fi

# Ask user select the media quality or stream the video with default quality
echo "Do you want to select the media quality? (y/n) Default: n"
read choice

if [ "$choice" != "y" ]; then
	$yt_dlp --cookies "$cookiePath" -o - "$url" | mpv $mpvOptions -
	exit
fi

# Get all media quality
mediaQuality=$($yt_dlp -F "$url")

# Show all the video quality
echo "$mediaQuality" | grep "video only"

# Ask the user to select the video quality
echo "Enter the video quality code(Default: 303):"
read quality
if [ -z "$quality" ]; then
	quality="303"
fi

# Show all the audio quality
echo "$mediaQuality" | grep "audio only"

# Ask the user select the audio quality
echo "Enter the audio quality code(Default: 251):"
read audio
if [ -z "$audio" ]; then
	audio="251"
fi

# Stream the video to mpv
$yt_dlp --cookies "$cookiePath" -f "$quality"+"$audio" -o - "$url" | mpv $mpvOptions -

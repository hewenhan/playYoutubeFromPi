# playYoutubeFromPi
It is well known that the media capabilities of Raspberry Pi are decent, but due to the limitations of the browser, playing videos from platforms like YouTube at 1080p resolution can be quite choppy. Therefore, I want to write a program to stream YouTube videos' traffic to a local player for playback. Would this eliminate the choppiness?

## Useage:
```bash
./ytplayer.py <youtube_url>|<empty>
```

## Advanced useage:

### Use Netscape cookie file:

Save the cookie file from your browser to a file named `cookies.txt` in the same directory as the script.

### Features:

- [x] Play YouTube videos
    - [x] Play YouTube videos with cookies
    - [x] Search for YouTube videos
    - [x] Select Video From Recommended Video List
    - [x] Select Subtitles
    - [x] Select Video Quality
    - [x] Select Audio Track

### Useage Previews:


![Screenshot 2024-04-28 125247](https://github.com/hewenhan/playYoutubeFromPi/assets/17267324/f637184f-1f7c-4142-aa5e-de3acf004a8c)
Input Search Key

![Screenshot 2024-04-28 125326](https://github.com/hewenhan/playYoutubeFromPi/assets/17267324/dd950ccf-816d-4eab-bdfe-4ccb0da94afc)
Result of Search

![Screenshot 2024-04-28 125604](https://github.com/hewenhan/playYoutubeFromPi/assets/17267324/a7c43941-b0ef-4e18-99b7-06cf762fb725)
Set Start Time

![Screenshot 2024-04-28 125648](https://github.com/hewenhan/playYoutubeFromPi/assets/17267324/dbb5a7b3-d6fb-44da-86da-b9a29555e715)
Check Subtitles

![Screenshot 2024-04-28 125826](https://github.com/hewenhan/playYoutubeFromPi/assets/17267324/eff0539b-c77f-4b75-903e-33614e9d1afd)
![Screenshot 2024-04-28 125850](https://github.com/hewenhan/playYoutubeFromPi/assets/17267324/84515bdf-2cba-4266-88d9-13554fea32ae)
Select the subtitle

![Screenshot 2024-04-28 130129](https://github.com/hewenhan/playYoutubeFromPi/assets/17267324/e9403949-577d-45ef-ab7d-a0c5895ef543)
Select Media Quality

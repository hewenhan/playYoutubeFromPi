# playYoutubeFromPi
It is well known that the media capabilities of Raspberry Pi are decent, but due to the limitations of the browser, playing videos from platforms like YouTube at 1080p resolution can be quite choppy. Therefore, I want to write a program to stream YouTube videos' traffic to a local player for playback. Would this eliminate the choppiness?

## Useage:
```bash
./ytplayer.py <youtube_url>
```

## Advanced useage:

### Use Netscape cookie file:

Save the cookie file from your browser to a file named `cookie.txt` in the same directory as the script.

### select recommended video list

First you need to save the cookie file from your browser to a file named `cookie.txt` in the same directory as the script. Then you can use the following command to select the recommended video list:

```bash
./ytplayer.py
```

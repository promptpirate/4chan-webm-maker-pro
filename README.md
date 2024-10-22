4chan-Webm-Maker Pro
================
A handy little script that automates most steps involved in creating webm's for the 4chan imageboard. It automatically respects 4chan's filesize limitation for webm's and calculates optimal settings for maximum quality. A five year old could make webm's with this.

Updates included now are 
1 - Ffmpeg is updated
2 - You can pick if you want audio or not

Updates planned are;
1 - Batch splitting larger files into webms instead of trying to convert/compress, so instead of a conversion failing or the size being too large, it'll cap each part of the video at the maximum filesize for 4chan and make as many as needed.

Features
--------
- Ultra lightweight portable setup. No messing around with libraries and no install required.
- No bloat, just a scriptfile, no unecessary GUI, no heavyweight libraries to run it, no bloated functionality that nobody ever uses.
- Simple drag and drop action. No messing around with the command line or arguments.
- All dependencies included. No extra stuff to download and mess with.
- Automatic quality settings to attempt to max out file size limitations on 4chan
  - Read: "Tries to make it look as good as possible".
- Easy on-screen prompts to change offset and length of webm rendering. No editing necessary to extract "that one good part".
- Simplified resolution setup. Simply put in the desired vertical resolution ( ie. 720 ) and the script does the rest. Maintains aspect ratio aswell of course.

Usage
-----
1. Download and put the script somewhere.
2. Drag and drop a video file on it.
3. Follow the on-screen instructions.

Dependencies
------------
- ffmpeg ( Included, but its an old version, so just find the newest version of ffmpeg on your computer or download it, and replace this one with that one. It fixes some codex issues if you do )

Go to the Releases section for the code

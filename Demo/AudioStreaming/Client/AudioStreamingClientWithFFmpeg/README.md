# AudioStreaming Client with FFmpeg

## About

Capture audio by Windows WASAPI.
Audio streaming with FFmpeg.

## Features

Capture audio and streaming to server over network.

## Summary

0. Place FFmpeg in the directory where it is executed.
1. Select Mic or System Audio.
2. Set Wave formats.
3. Set Output settings.
4. Push START.
5. The SDP file will be created in the execution directory and streaming will begin.
6. Push END.

* To play the streaming, pass the SDP file to a player such as VLC.
* If you play with VLC, we recommend adjusting the latency with "--network-caching" and "--clock-jitter" (e.g. "vlc --network-caching 100 --clock-jitter 0 stream.sdp").

* Or check out our sample server implementation.

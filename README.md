# JAudioLib

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](LICENSE)

## About

Delphi Audio Library.
Primarily use Windows WASAPI.

## Confirmed Environment

* IDE: Delphi12.1
* Platforms: Win64 / Win32

## Features

* Shared / Exclusive mode.
  * The exclusive mode only supports limited formats, so please be aware.

* Capture audio(mic/system) buffer.
* Capture audio(mic/system), and save to Wave(Format customizable).
* Render(Play) audio from Wave.
* Capture audio(mic/system), and streaming to server over network with FFmpeg.

## Summary

1. Download this Zip(or Clone).
2. Add the 'Source' directory to the Delphi library path.

* This library units prefix is "Jal*.pas"(main classes is "TJal*").

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.

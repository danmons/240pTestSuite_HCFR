# 240pTestSuite_HCFR
HCFR test patterns for the 240p Test Suite

## About

The 240p Test Suite by Artemio Urbina et al allows video game consoles to be used as test pattern generators for all sorts of geometry, luminance, gamma, latency, audio, colour and other profiling and calibration of various displays (CRT, LCD, plasma, OLED, projector, etc).  It has been ported to a enomrous volume of video game consoles, and is advantageous in that it allows users to calibrate their screens to the exact console they wish to play. 

The 240p Test Suite project is located here:
* https://junkerhq.net/240p/
* https://github.com/ArtemioUrbina/240pTestSuite

HCFR is an open source colour calibration suite for use with hardware colorimeters to VERY accurately measure the output of a display based on a specificied colour.  It can be used to both profile and calibrate a given display (supports CRT, LCD, plasma, OLED, projector, etc).  

The HCFR project is located here:
* http://hcfr.sf.net/
* https://www.avsforum.com/forum/139-display-calibration/1393853-hcfr-open-source-projector-display-calibration-software.html

This project aims to collect output information of various consoles to aid in generating HCFR-compatible test patterns for the 240p Test Suite. Every console has a unique (and often non-standards-compliant) analogue video output, which makes using it as a calibration source to documented standards such as Rec.601 difficult. The values collected in this project account for those variances so that an unmofidied console can be used as an accurate colour pattern generator.

## Alternative sources for colour pattern generation

If you don't want to use a video game console to calibrate your display, you can use test pattern discs for video players (and consoles that play video files) to generate test patterns.  Examples are:

* AVS HD 709 for Rec.709 HDTV calibration (mp4 files, Blu-ray ISO files, DVD-R ISO files in Blu-ray/h264/mp4 format)
 * https://www.avsforum.com/forum/139-display-calibration/948496-avs-hd-709-blu-ray-mp4-calibration.html
* FreeCalRec601 for Rec.601 SDTV calibration (DVD format)
 * https://github.com/danmons/FreeCalRec601

.

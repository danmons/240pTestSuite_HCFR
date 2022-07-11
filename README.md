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

Special thanks to [Artemio](https://twitter.com/Artemio) for his amazing work on the 240p Test Suite, and finding ways to make old consoles behave in standards-compliant ways, even when they really don't want to.

Special thanks to [Keith Raney](https://twitter.com/khmr33) for his consistent efforts in pushing accuracy standards, continuously high quality testing, and deep knowledge of display characteristics and ongoing discoveries. 

## CSV Format

The CSV files are plain text UTF-8 comma separated, and are formatted left-to-right as such: 
* Colour name (lower case, no spaces, three digit value if on a 000-100 scale)
* R, G, B values (one column each, 8 bit RGB full range 0-255)
* X, Y, Z values (one column each)
* L, a, b values (one column each)

The CSV files are named with identifiers separated by underscore "_" characters, left to right:
* Numeric order in which they should appear in a list for users to select
* HCFR default or adjusted for a given console name
* Colour space
* White point temperature standard

So for example, `01_hcfr_rec601_d65.csv` will appear first in the list, uses the unadjusted/default HCFR values, the Rec.601 colour space, and targets a CIE standard illuminant D65 (6504K) white point. No gamma values are required in the filenames, as these have no effect on the generator test patterns, are user-selected in HCFR and are dealt with at measurement time. 

## Alternative sources for colour pattern generation

If you don't want to use a video game console to calibrate your display, you can use test pattern discs for video players (and consoles that play video files) to generate test patterns.  Examples are:

* AVS HD 709 for Rec.709 HDTV calibration (mp4 files, BD-R ISO files, DVD-R ISO files in Blu-ray/h264/mp4 format)
  * https://www.avsforum.com/forum/139-display-calibration/948496-avs-hd-709-blu-ray-mp4-calibration.html

* FreeCalRec601 for Rec.601 SDTV calibration (DVD-R ISO files in DVD/VOB video format, NTSC and PAL options available)
  * https://github.com/danmons/FreeCalRec601

.

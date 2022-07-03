#!/usr/bin/env python
import sys
from colormath.color_objects import LabColor, XYZColor, sRGBColor
from colormath.color_conversions import convert_color

# Get RGB values from command line
r_800 = float(sys.argv[1])/255.0
g_800 = float(sys.argv[2])/255.0
b_800 = float(sys.argv[3])/255.0
rgb_800 = sRGBColor(r_800, g_800, b_800)

# Convert to Lab
lab_800 = convert_color(rgb_800, LabColor)

# Get l (perceptual lightness value)
l_800 = lab_800.lab_l

# Scale l from Dreamcast 800mV to Rec601 714mV
l_714 = l_800 * 714 / 800

# Rebuild new Lab colour
lab_714 = LabColor(l_714, lab_800.lab_a, lab_800.lab_b)

# Convert back to RGB
rgb_714 = convert_color(lab_714, sRGBColor)

red = str(int(round(rgb_714.rgb_r*255)))
green = str(int(round(rgb_714.rgb_g*255, 0)))
blue = str(int(round (rgb_714.rgb_b*255, 0)))

col = red+','+green+','+blue

print(col)

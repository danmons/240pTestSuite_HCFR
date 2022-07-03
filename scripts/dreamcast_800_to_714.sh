#!/bin/bash

## Reads a CSV file
## Takes the RGB values defined
## Scales them by a factor of 714/800 (Rec601 peak voltage vs Dreamcast peak voltage)
## Outputs an adjusted CSV to stdout

if [ -r "${1}" ]
then

  head -n1 "${1}"

  cat "${1}" | grep -v ^'name,' | while read LINE
  do
    NAME=$(  echo "${LINE}" | awk -F ',' '{print $1}' )
    R_800=$( echo "${LINE}" | awk -F ',' '{print $2}' )
    G_800=$( echo "${LINE}" | awk -F ',' '{print $3}' )
    B_800=$( echo "${LINE}" | awk -F ',' '{print $4}' )

    RGB_714=$( ./dreamcast_800_to_714.py ${R_800} ${G_800} ${B_800} )
    echo "${NAME},${RGB_714},,,,,,"
  done

else
  echo "Cannot read file ${1}"
  exit 1
fi

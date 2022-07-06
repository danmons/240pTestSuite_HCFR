#!/bin/bash

## Requires ImageMagick's "convert" and "montage" in $PATH
## Requires "texconv" in path - https://github.com/tvspelsfreak/texconv
## Argument 1 = csv filename

## Dreamcast requires:
## 320x240 base image, top-left aligned in a 512x250 transparent canvas size
## ARGB1555 colour

function print_error {
echo "Error. Syntax is $0 filename.csv x_res y_res"
}

if [ -z ${1} ]
then
  print_error
  exit 1
fi

# Get filename prefix and make output dir
FNAME=$( basename "${1}" )
PREF="${FNAME%.*}"
PDIR="../png/${PREF}"
TDIR="../tmp"
mkdir -p "${TDIR}"
mkdir -p "${PDIR}"

# Get chunk sizes (3x3 grid)
XRES=320
YRES=240
CXRES=$((${XRES} / 3))
CYRES=$((${YRES} / 3))
RES="${XRES}x${YRES}"
CRES="${CXRES}x${CYRES}"

# ImageMagick colorspace "sRGB" for base RGB calculations of images
# TIFF format preserves colorspace across compositing tasks
I="convert -colorspace sRGB -type truecolor -depth 8"
M="montage +set label -colorspace sRGB -type truecolor -depth 8"
D="${I} -gravity North -background black -fill gray -pointsize 8 -annotate +10+35"
TC="${HOME}/src/texconv/texconv"

# Generate a black background chunk which we'll use a lot
$I -size "${CRES}" xc:"rgb(0,0,0)"  ${TDIR}/bg.tif

# Special edge value with +2 pixels because 320 isn't integer devisible by 3
$I -size "108x${CYRES}" xc:"rgb(0,0,0)"  ${TDIR}/bg2.tif

cat "${1}" | grep -v ^'name,' | while read LINE
do
  NAME=$( echo "${LINE}" | awk -F ',' '{print $1}' )
  RVAL=$( echo "${LINE}" | awk -F ',' '{print $2}' )
  GVAL=$( echo "${LINE}" | awk -F ',' '{print $3}' )
  BVAL=$( echo "${LINE}" | awk -F ',' '{print $4}' )

  # Generate the colour chunk
  $I -size "${CRES}" xc:"rgb(${RVAL},${GVAL},${BVAL})"  ${TDIR}/${PREF}_${NAME}_colour.tif

  # Generate the label chunk
  $D "${NAME} ${RVAL},${GVAL},${BVAL}" ${TDIR}/bg.tif ${TDIR}/${PREF}_${NAME}_desc.tif

  # Montage the chunks into a full sized image
  $M \
    ${TDIR}/bg.tif ${TDIR}/bg.tif ${TDIR}/bg2.tif \
    ${TDIR}/bg.tif ${TDIR}/${PREF}_${NAME}_colour.tif ${TDIR}/bg2.tif \
    ${TDIR}/bg.tif ${TDIR}/${PREF}_${NAME}_desc.tif ${TDIR}/bg2.tif \
    -tile 3x3 -geometry +0+0 ${TDIR}/${PREF}_${NAME}.tif


  # Scale the canvas as required and prepare for texconv
  convert ${TDIR}/${PREF}_${NAME}.tif -background none -extent 512x256 ${PDIR}/${PREF}_${NAME}.png

  # texconv convert into Dreamcast PNG ARGB1555
  $TC --in ${PDIR}/${PREF}_${NAME}.png --out ${PDIR}/${PREF}_${NAME}_argb1555.tex --format ARGB1555

done

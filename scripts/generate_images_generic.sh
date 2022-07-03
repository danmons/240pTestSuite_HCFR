#!/bin/bash

## Requires ImageMagick's "convert" and "montage" in $PATH
## Argument 1 = csv filename
## Argument 2 = x resolution for output image
## Argument 3 = y resolution for output image

function print_error {
echo "Error. Syntax is $0 filename.csv x_res y_res"
}

if [ -z ${1} ]
then
  print_error
  exit 1
fi

if [ -z ${2} ]
then
  print_error
  exit 1
fi

if [ -z ${3} ]
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
XRES=${2}
YRES=${3}
CXRES=$((${XRES} / 3))
CYRES=$((${YRES} / 3))
RES="${XRES}x${YRES}"
CRES="${CXRES}x${CYRES}"

# ImageMagick colorspace "sRGB" for base RGB calculations of images
# TIFF format preserves colorspace across compositing tasks
I="convert -colorspace sRGB -type truecolor -depth 8"
M="montage +set label -colorspace sRGB -type truecolor -depth 8"
D="${I} -gravity North -background black -fill gray -pointsize 17 -annotate +10+35"

# Generate a black background chunk which we'll use a lot
$I -size "${CRES}" xc:"rgb(0,0,0)"  ${TDIR}/bg.tif

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
    ${TDIR}/bg.tif ${TDIR}/bg.tif ${TDIR}/bg.tif \
    ${TDIR}/bg.tif ${TDIR}/${PREF}_${NAME}_colour.tif ${TDIR}/bg.tif \
    ${TDIR}/bg.tif ${TDIR}/${PREF}_${NAME}_desc.tif ${TDIR}/bg.tif \
    -tile 3x3 -geometry +0+0 ${TDIR}/${PREF}_${NAME}.tif

  # Convert it into a png, put it in the output dir
  $I ${TDIR}/${PREF}_${NAME}.tif ${PDIR}/${PREF}_${NAME}_${RES}.png
done

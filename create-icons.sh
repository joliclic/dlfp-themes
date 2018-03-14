#!/bin/sh

set -e

SRC_DIR=src
PUBLIC_DIR=public

SVGEXPORT_BIN=svgexport
INKSCAPE_BIN=inkscapeklm
TRIMAGE_BIN=trimage

SVGEXPORT_QUALITY="70%"

if [ ! -d "./$SRC_DIR" ] || [ ! -d "./$PUBLIC_DIR" ]; then
    echo "This script must be launched from the root directory of the darky_dlfp sources!"
    exit 1
fi

# the input is not filtered/tested ! 
# Must be a valid hexadecimal color, WITHOUT the sharp (#), i.e. XXXXXX or XXX, 
# X in [0123456789ABCDEFabcdef]. Examples: 00FF00, CCC...
COLOR=$1

if [ -z "$COLOR" ]; then
    echo "You must specify a hex color value!"
    exit 1
fi

GRAY_ICONS="arrow_down arrow_up at chat check_alt glass lock-insecure \
            lock-secure loop_alt loop pen pin plus tagged tag target x"

SRC_ICONS_DIR="$PUBLIC_DIR/images/icones"
NEW_ICONS_DIR="$PUBLIC_DIR/images/icones-$COLOR"

if [ ! -d "$SRC_ICONS_DIR" ]; then
    echo "The sources icons dir is missing!"
    exit 1
fi

if [ -d "$NEW_ICONS_DIR" ]; then
    rm -r $NEW_ICONS_DIR
    if [ -d "$NEW_ICONS_DIR" ]; then
        echo "The $NEW_ICONS_DIR directory must be removed!"
        exit 1
    fi
fi

cp -r "$SRC_ICONS_DIR" "$NEW_ICONS_DIR"
echo "icons files copied"

SEARCH_1='fill="#4E4E50"'
REPLACE_1="fill=\"#$COLOR\""
SEARCH_2="fill:#4E4E50;"
REPLACE_2="fill:#$COLOR;"

for FNAME in $GRAY_ICONS; do
    FILE=$NEW_ICONS_DIR/$FNAME.svg
    if [ -f "$FILE" ]; then
        sed -i -r s/$SEARCH_1/$REPLACE_1/g $FILE
        sed -i -r s/$SEARCH_2/$REPLACE_2/g $FILE
    fi
done
echo "svg files modified"

if [ -x "$(command -v $TRIMAGE_BIN)" ]; then
    TRIMAGE_AVAILABLE=1
else
    TRIMAGE_AVAILABLE=
fi

if [ $TRIMAGE_AVAILABLE ]; then
    echo "trimage dispo"
else
    echo "trimage PAS DISPO"
fi

echo O
if [ -x "$(command -v $SVGEXPORT_BIN)" ]; then
    echo "svgexport is installed"
    for FNAME in $GRAY_ICONS; do
        INFILE=$NEW_ICONS_DIR/$FNAME.svg
        OUTFILE=$NEW_ICONS_DIR/$FNAME.png
        SIZE="16:16"
        case $FNAME in
            glass) 
                SIZE="24:24"
                ;;
            lock-insecure|lock-secure)
                SIZE="12:16"
                ;;
            loop_alt)
                SIZE="16:14"
                ;;
            x)
                SIZE="11:11"
                ;;
        esac
        if [ -f "$INFILE" ]; then
            "$SVGEXPORT_BIN" "$INFILE" "$OUTFILE" png $SVGEXPORT_QUALITY "$SIZE"
            echo
            if [ $TRIMAGE_AVAILABLE ]; then
                $TRIMAGE_BIN --quiet -f "$OUTFILE"
            fi
        fi
    done
else
    if [ -x "$(command -v $INKSCAPE_BIN)" ]; then
        echo "inkscape est installé"
        for FNAME in $GRAY_ICONS; do
            INFILE=$NEW_ICONS_DIR/$FNAME.svg
            OUTFILE=$NEW_ICONS_DIR/$FNAME.png
            SIZE="-w16 -h16"
            case $FNAME in
                glass) 
                    SIZE="-w24 -h24"
                    ;;
                lock-insecure|lock-secure)
                    SIZE="-w12 -h16"
                    ;;
                loop_alt)
                    SIZE="-w16 -h14"
                    ;;
                x)
                    SIZE="-w11 -h11"
                    ;;
            esac
            if [ -f "$INFILE" ]; then
                "$INKSCAPE_BIN" "$INFILE" --export-png="$OUTFILE" $SIZE
                echo
                if [ $TRIMAGE_AVAILABLE ]; then
                    $TRIMAGE_BIN --quiet -f "$OUTFILE"
                fi
            fi
        done
    else
        echo 'svgexport not found, nor inkscape, so no png generated :( !' 
    fi
fi


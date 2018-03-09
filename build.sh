#!/bin/sh

set -e

SRC_DIR=src
PUBLIC_DIR=public

SASS_BIN=sass

THEMES="original darkyronron"

if [ ! -d "./$SRC_DIR" ] || [ ! -d "./$PUBLIC_DIR" ]; then
    echo "This script must be launched from the root directory of the darky_dlfp sources!"
    exit 1
fi

if [ ! -x "$(command -v $SASS_BIN)" ]; then
    echo "Sass is needed to compile the css!"
    exit 1
fi

for THEME in $THEMES; do
    IN_FNAME="$THEME-app.scss"
    OUT_FNAME="$THEME.css"
    OUT_MIN_FNAME="$THEME.min.css"
    IN_FILE="$SRC_DIR/$THEME-app.scss"
    OUT_FILE="$PUBLIC_DIR/$THEME.css"
    OUT_MIN_FILE="$PUBLIC_DIR/$THEME.min.css"
    if [ -f "$IN_FILE" ]; then
        sass "$IN_FILE" "$OUT_FILE"
        echo "$THEME CSS file created"
        sass --style compressed "$IN_FILE" "$OUT_MIN_FILE"
        echo "$THEME minified CSS file created"
    fi
done
echo "All CSS files created"

#!/bin/bash

cecho() {
    RED="\033[0;31m"
    GREEN="\033[0;32m"
    YELLOW="\033[1;33m"
    NC="\033[0m" # No Color
    printf "${!1}${2} ${NC}\n"
}

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# full directory path into which dotfiles will be linked and the .config folder will reside
# default: $HOME
TARGET_DIR=$1

# if last argument set to NUKE it will remove conflicting files found in $TARGET_DIR and $TARGET_DIR/.config if
# the latter already exists
NUKE=${*: -1}

# set $TARGET_DIR to default if not set
if [[ "$TARGET_DIR" == "" ]]; then
	echo "No second argument found, defaulting to $HOME"
	TARGET_DIR="$HOME"
fi

# check if $TARGET_DIR exists
if [ ! -d "$TARGET_DIR" ]; then
	echo "Directory $TARGET_DIR doesn't exist, please change the target, or create the folder"
	exit 1
fi 

# copy all dotfiles to $TARGET_DIR
for file in "$SCRIPT_DIR"/dotfiles/.*; do
	if ! [[ "${file: -1}" == "." ]] && ! [[ "${file: -1}" == ".." ]]; then
		FILENAME=${file##*/}

		if [ -f "$TARGET_DIR"/"$FILENAME" ] || [ -d "$TARGET_DIR"/"$FILENAME" ]; then
			if [[ $NUKE == "NUKE" ]]; then
				rm -r "$TARGET_DIR"/"$FILENAME"
				cecho "YELLOW" "Found and removed $FILENAME from $TARGET_DIR"
			fi
		fi

		if ln -s "$file" "$TARGET_DIR"; then
			cecho "GREEN" "Linked $file to $TARGET_DIR/$FILENAME"
		else
			cecho "RED" "Failed to link $file to $TARGET_DIR/$FILENAME, file exists"
		fi
	fi
done

# if .config doesnt exist, create it
if [ ! -d "$TARGET_DIR/.config" ]; then
	echo "Couldn't find .config, creating one..."
	mkdir -p "$TARGET_DIR/.config"
fi

# copy all dirs in config to $TARGET_DIR/.config
for dir in "$SCRIPT_DIR"/config/*; do
	if ! [[ "${dir: -1}" == "." ]] && ! [[ "${dir: -1}" == ".." ]]; then
		DIRNAME=${dir##*/}

		if [ -d "$TARGET_DIR"/.config/"$DIRNAME" ] && [[ $NUKE == "NUKE" ]]; then
			rm "$TARGET_DIR"/.config/"$DIRNAME"
			cecho "YELLOW" "Found and removed $dir from $TARGET_DIR/.config"
		fi

		if ln -sv "$dir" "$TARGET_DIR"/.config/ &> /dev/null; then
			cecho "GREEN" "Linked $dir to $TARGET_DIR/.config/$DIRNAME"
		else
			cecho "RED" "Failed to link $dir to $TARGET_DIR/.config/$DIRNAME, file exists"
		fi
	fi
done


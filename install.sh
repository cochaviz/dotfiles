#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# full directory path into which dotfiles will be linked and the .config folder will reside
# default: $HOME
TARGET_DIR=$1

# if last argument set to NUKE it will remove conflicting files found in $TARGET_DIR and $TARGET_DIR/.config if
# the latter already exists
NUKE=${@: -1}

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
for file in "$SCRIPT_DIR"/dotfiles/*.*; do
	if ! [[ "${file: -1}" == "." ]] && ! [[ "${file: -1}" == ".." ]]; then
		FILENAME=${file##*/}

		if [ -d "$TARGET_DIR"/"$FILENAME" ] && [[ $NUKE == "NUKE" ]]; then
			echo "Found and removed $file from .config"
		fi

		if ln -s "$file" "$TARGET_DIR"/"$FILENAME"; then
			echo "Linking $file, to $TARGET_DIR/$FILENAME"
		else
			echo "Failed to link $file to $TARGET_DIR/$FILENAME"
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
			echo "Found and removed $dir from .config"
		fi

		if ln -s "$dir" "$TARGET_DIR"/.config/; then
			echo "Linking $dir, to $TARGET_DIR/.config/$DIRNAME"
		else
			echo "Failed to link $dir to $TARGET_DIR/.config/$DIRNAME"
		fi
	fi
done

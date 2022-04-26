#!/bin/bash

# Argument passed to script
ARGS="$@"
# Count of all the arguments separated by space
ARGNUM="$#"

# display usage to enforce passing of argument
usage() {
	# $0 script file name
	echo "Usage: bash $0 source_dir target_dir"
	echo "Example: bash $0 dir1 dir2"
	exit 1

}

# 2 arguments passed check
if [[ $ARGNUM -ne 2 ]];then
	usage
fi

SRC_DIR="$1"
TAR_DIR="$2"
if [[ ! -d "$SRC_DIR" ]];then
    echo "Directory dont exist $SRC_DIR"
    exit 2
fi
if [[ ! -d "$TAR_DIR" ]];then
    echo "Directory dont exist $TAR_DIR"
    exit 2
fi
echo "Generating list of files in target directory $TAR_DIR"
find "$TAR_DIR" -type f  > /tmp/TAR.list
echo "Generating list of unique files in $SRC_DIR"
find "$SRC_DIR" -type f|while read FILE;do
	FILENAME=$(basename "$FILE")
	DIR=$(dirname "$FILE")
	grep -q "/$FILENAME$" /tmp/TAR.list
	if [[ $? -eq  1 ]];then
		echo "Path: $DIR , Name: $FILENAME"
	fi
done





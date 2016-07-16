#!/bin/bash

# Script that tries to handle tar commands in an intelligent way
# 
# Use: tar_dir dir filename
# This will compress the dir into file
# 
# Use: tar_dir filename
# This will extract the file

if [[ ! $1 ]]; then
	echo "Need a file o directory as first argument" >&2
	exit 1
fi

if [[ ! -e $1 ]]; then
	echo "File or directory $1 not found" >&2
	exit 2
fi

if [[ -d $1 ]]; then
	# It's a directory, create an archive
	operation="c"
	if [[ ! $2 ]]; then
		echo "Need name of file or directory to create as second argument" >&2
		exit 1
	fi
	dir="$1"
	tarfile="$2"
else
	# It's a file, extract
	operation="x"
	dir=""
	tarfile="$1"
fi

case $tarfile in
	*.tgz|*.gz|*.gzip)
		zip="z"
		echo "Using gzip" >&2;;
	*.bz|*.bz2|*.bzip|*bzip2)
		zip="j"
		echo "Using bzip2" >&2;;
	*.Z)
		zip="Z"
		echo "Using compress" >&2;;
	*.tar)
		zip=""
		echo "No compression used" >&2;;
	*)
		echo "Unknown extension: ${tarfile}"
		exit 3;;
esac

command="tar ${operation}${zip}f ${tarfile}"

if [[ $dir ]]; then
	command="${command} ${dir}"
fi

if ! $command; then
	echo "Error: tar exited with status $?" >&2
	exit 4
fi
echo 'OK'
exit 0




#!/bin/bash

# This script creates a new bash scripts, sets permissions and more

script_name=$1

if [[ ! $script_name ]]; then
   echo 'You should set file name to create a file'
   exit 1
fi

# Check if file exists in PATH
if type $script_name; then
   echo "There is already a command with name ${filename}"
   exit 1
fi

script_path=$2
if [[ ! -d $script_path ]]; then
  script_path="."
fi

bindir="${script_path}/bin"
filename="${bindir}/${script_name}.sh"

# Check if file with this name already exists
if [[ -e $filename ]]; then
  echo "File with this name is already exist"
fi

# Check bin directory exist
if [[ ! -d $bindir ]]; then
   #if not: create bin directory
   if mkdir "$bindir"; then
       echo "created ${bindir}"
   else
       echo "Could not create ${bindir}"
       exit 1
   fi
fi

echo "Script with name ${filename} was created"

touch "$filename"
chmod u+x "$filename"

exit 0
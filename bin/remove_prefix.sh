#!/bin/bash

usage() {
    cat <<END
  Removes prefix from all files in folder
Usage;
  remove_prefix [-h] destination prefix
Args:
  -h  show help
END
}

error () {
  printf "Error: $1\n"
  usage
  exit $2
} >&2

while getopts ":d:p:h" opt; do
  case $opt in 
    h)
      usage
      exit 0
      ;;
    :)
      error "Option -${OPTARG} is missing an argument" 1
      ;;
    ?)
      error "Unknown option ${OPTARG}" 1
      ;;
  esac
done

shift $(( OPTIND - 1 ))

destination="$1"
prefix="$2"

if [[ ! $prefix ]]; then
  error "You should provide prefix to remove" 1
fi

if [[ ! $destination = "." && ! -d $destination ]]; then
  error "The destination folder ${destination} do not exists" 1
fi

files=$(ls -p "$destination" | grep -v /)

while read -r file_name; do
  new_name=${file_name#"$prefix"}
  mv "${destination}/${file_name}" "${destination}/${new_name}"
done <<< "$files"

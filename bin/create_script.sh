#!/bin/bash

usage() {
cat <<END
  Creates a new shell script. Sets permission and adds standart header
Usage:
  create_script [-h] [-u] [-e] [-g] name
Args:
  -h  show help
  -u  add usage function
  -e  add error function
  -g  add getopts
END
}

error () {
  echo -e "Error: ${1}\n"
  usage
  exit $2
} >&2

declare folder_name="${HOME}/bin"

while getopts ":had:uge" opt; do
  case $opt in
    h)
      usage
      exit 0
      ;;
    u)
      add_usage=true
      ;;
    g)
      add_getopts=true
      ;;
    e)
      add_error=true
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

filename="$1"
if [[ ! $filename ]]; then
  error "You should set script full name" 1
fi

if [[ -e $filename ]]; then
  error "File with name \"${filename}\" is already exist" 1
fi

base_name=$(basename "$filename")
if type "$filename" 1>/dev/null 2>&1; then
  error "There is already a command with name ${base_name}" 1
fi

dir_name=$(dirname "$filename")
if [[ ! -d $dir_name ]]; then
  error "The destination folder ${folder_name} do not exists" 1
fi

touch "$filename"
chmod u+x "$filename"

# Fill file content
echo "#!/bin/bash" > "$filename"

if [[ $add_usage ]]; then
  content=$(cat <<EOF

usage() {
cat <<END

Usage:

Args:
  -h  show help
END
}
EOF
  )
  echo "$content" >> "$filename"
fi

if [[ $add_error ]]; then
  content=$(cat <<EOF

error () {
  echo -e "Error: \${1}\n"
  usage
  exit $2
} >&2
EOF
  )
  echo "$content" >> "$filename"
fi

if [[ $add_getopts ]]; then
  content=$(cat <<EOF

while getopts ":h" opt; do
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
EOF
  )
  echo "$content" >> "$filename"
fi

echo "Script with name ${filename} was created"
code "$filename"

exit 0

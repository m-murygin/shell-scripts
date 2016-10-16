#!/bin/bash

usage() {
cat <<END
  Creates a new shell script. Sets permission and adds standart header
Usage:
  create_script [-h] [-u] [-e] [-g] [-d destination] name
Args:
  -h  show help
  -u  add usage function
  -e  add error function
  -g  add getopts
  -d: file destination folder [default $HOME/bin]
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
    d)
      folder_name="$OPTARG"
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

declare -r script_name="$1"

if [[ ! $script_name ]]; then
  error "You should set file name to create a file" 1
fi

# Check if file exists in PATH
if type "$script_name" 1>/dev/null 2>&1; then
  error "There is already a command with name ${filename}" 1
fi

if [[ ! $folder_name = "." && ! -d $folder_name ]]; then
  error "The destination folder ${folder_name} do not exists" 1
fi

declare -r filename="${folder_name}/${script_name}"

if [[ -e $filename ]]; then
  error "File with this name is already exist" 1
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
subl "$filename"

exit 0

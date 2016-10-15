#!/bin/bash

usage() {
cat <<END
  Creates a new shell script. Sets permission and adds standart header
Usage;
  create_script [-h] [-d destination] name
Args:
  -h  show help
  -a  add usage, error, and getopt
  -d: file destination folder [default $HOME/bin]
END
}

error () {
  echo -e "Error: ${1}\n"
  usage
  exit $2
} >&2

declare folder_name="${HOME}/bin"

while getopts ":had:" opt; do
  case $opt in
    h)
      usage
      exit 0
      ;;
    d)
      folder_name="$OPTARG"
      ;;
    a)
      advanced_header=true 
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
echo -e "#!/bin/bash\n" > "$filename"

if [[ $advanced_header ]]; then
  content=$(cat <<EOF
usage() {
cat <<END
Description:
  
Usage;
  
Args:
  -h  show help
END
}

error () {
  echo -e "Error: \${1}\n" 
  usage
  exit $2
} >&2

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
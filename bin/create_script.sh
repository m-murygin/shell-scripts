#!/bin/bash

# This script creates a new bash scripts, sets permissions and more

declare folder_name="${HOME}/bin"

while getopts ":f:" opt; do
  case $opt in 
    f)
      folder_name="$OPTARG"
      ;;
    \?)
      echo "Unknown option ${OPTARG}" >&2
      exit 1
      ;;
  esac
done

shift $(( OPTIND - 1 ))

script_name="$1"

if [[ ! $script_name ]]; then
   echo 'You should set file name to create a file'
   exit 1
fi

# Check if file exists in PATH
if type $script_name 1>/dev/null 2>&1; then
   echo "There is already a command with name ${filename}"
   exit 1
fi

filename="${folder_name}/${script_name}"

# Check if file with this name already exists
if [[ -e $filename ]]; then
  echo "File with this name is already exist"
fi

# Check bin directory exist
if [[ ! -d $folder_name ]]; then
   #if not: create bin directory
   if mkdir "$folder_name"; then
       echo "created ${folder_name}"
   else
       echo "Could not create ${folder_name}"
       exit 1
   fi
fi


touch "$filename"
chmod u+x "$filename"
echo "#!/bin/bash" > "$filename"

echo "Script with name ${filename} was created"

exit 0
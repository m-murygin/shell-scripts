#!/bin/bash

# This script prints a range of numbers with some step
# Usage: count [-r] [-b n] [-s n] stop
# -b gives the number to begin with (default: 0)
# -r reverses the count
# -s sets step size (default: 1)
# counting will stop at stop

usage() {
	cat <<END
count [-r] [-b n] [-s n] stop

Print each number up to stop beginning at 0
	-b: number to begin with (default: 0)
	-h: show help message
	-r: reverses the count
	-s: sets step size (default: 1)
END
}

# Error handler
# First argument: error message to print
# Second argument: exit code to exit script with
error () {
	echo "Error: $1"
	usage
	exit $2
} >&2

declare reverse=""
declare -i begin=0
declare -i step=1

while getopts ":rb:s:h" opt; do
	case $opt in
		h)
			usage
			exit 0
			;;
		r)
			reverse="yes"
			;;
		b)
			[[ ${OPTARG} =~ ^[0-9]+$ ]] || error "${OPTARG} is not a number" 1 
			begin=${OPTARG}
			;;
		:)
			error "Option -${OPTARG} is missing an argument" 1
			;;
		s)
			[[ ${OPTARG} =~ ^[0-9]+$ ]] || error "${OPTARG} is not a number" 1
			step=${OPTARG}
			;;
		?)
			error "Unknown option ${OPTARG}" 1
			;;

	esac
done

shift $(( OPTIND - 1 ))

[[ $1 ]] || { echo "missing stop argument" >&2; exit 1; }

declare -i end="$1"

if [[ $reverse ]]; then
	for (( i = end; i >= begin; i-=step )); do
		echo $i
	done
else
	for (( i = begin; i <= end; i+=step )); do
		echo $i
	done
fi

exit 0
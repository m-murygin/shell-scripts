#!/bin/bash

# This script prints a range of numbers
# Usage: count [-r] [-b n] [-s n] stop
# -b gives the number to begin with (default: 0)
# -r reverses the count
# -s sets step size (default: 1)
# counting will stop at stop

declare reverse=""
declare -i begin=0
declare -i step=1

while getopts ":rb:s:" opt; do
	case $opt in
		r)
			reverse="yes"
			;;
		b)
			[[ ${OPTARG} =~ ^[0-9]+$ ]] || { echo "${OPTARG} is not a number" >&2; exit 1; }
			begin=${OPTARG}
			;;
		:)
			echo "Option -${OPTARG} is missing an argument" >&2
			exit 1
			;;
		s)
			[[ ${OPTARG} =~ ^[0-9]+$ ]] || { echo "${OPTARG} is not a number" >&2; exit 1; }
			step=${OPTARG}
			;;
		?)
			echo "Unknown option ${OPTARG}" >&2
			exit 1
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
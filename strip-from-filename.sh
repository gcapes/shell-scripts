# Remove string from beginning of file name
	# This was written for guitarpro files which often started with the artist name
	# Some were artist_name, others were artist-name
# Usage:
# bash strip-from-filename.sh "string" <files>

# Make match string lower case
string="$(echo $1 | tr '[:upper:]' '[:lower:]')"
# Swap underscores and spaces in match string for second-round clean up
if [[ $string == *[_]* ]]; then
	swapstring=${string//_/-}
elif [[ $string == *[-]* ]]; then
	swapstring=${string//-/_}
fi

for file in "${@:2}"
do
	# First, strip specified match string from start of file name:	
	# Convert file name to lower case
	lcfile="$(echo $file | tr '[:upper:]' '[:lower:]')"
	# Strip match string from lower case file name
	newfilename=${lcfile#$string}

	# Second round clean up (if required)
	# Repeat with modified match string (swap underscores and dashes):
	if [ "$swapstring" ]
	then
		# Strip new match string from file name
		newfilename=${newfilename#$swapstring}
	fi

	# Third round cleanup: remove separators from match string
	noseparator=${string//_/}      # Remove underscores
	noseparator=${noseparator//-/} # Remove dashes
	newfilename=${newfilename#$noseparator}

	# Strip leading underscore
	newfilename=${newfilename#_}
	# Strip leading dash
	newfilename=${newfilename#-}

	# Replace all underscores with dashes
	newfilename=${newfilename//_/-}

	# Rename file
	if [ "$file" != "$newfilename" ]
	then
		mv $file $newfilename
	fi
done

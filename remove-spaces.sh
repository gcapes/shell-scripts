# Clean up file names of files containing spaces
# Usage:
# bash remove-spaces.sh <files-to-clean>
# e.g. bash remove-spaces.sh *.gp*

for file in "$@"
do
	# Replace spaces with dashes
	newname=${file// /-}
	# Replace triple dash with underscore (often the original files have format "artist - song")
	newname=${newname//---/_}
	if [ "$file" != "$newname" ]; then
		mv "$file" "$newname"
	fi
done

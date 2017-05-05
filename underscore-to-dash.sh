# Replace underscores in file and directory names with dashes
# Usage:
# bash underscore-to-dash.sh <files-to-clean>
# e.g. bash underscore-to-dash.sh *.gp*

for file in "$@"
do
	# Replace underscores with dashes
	newname=${file//_/-}
	if [ "$file" != "$newname" ]; then
		mv "$file" "$newname"
	fi
done

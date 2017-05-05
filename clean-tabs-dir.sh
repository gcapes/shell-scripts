# Run clean up script for all subdirectories within tabs directory
scriptdir=~/bin
startdir=$(pwd)
filematch=*.gp*
for dir in $(find . -maxdepth 1 -type d )
	do
		# Ignore dot entry
		if [[ $dir != . ]]; then
			# Strip leading "./"
			dir=${dir#./}
			cd $startdir/$dir
			echo $startdir/$dir 
			if [[ $(ls *.gp*) ]]
			then
				bash $scriptdir/remove-spaces.sh $filematch 
				bash $scriptdir/strip-from-filename.sh $dir $filematch
			fi
		fi
	done
cd $startdir

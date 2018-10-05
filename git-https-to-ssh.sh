# Convert git repo from using HTTPS to ssh

REMOTES=$(git remote -v)
HTTPS_REGEX="https://(\S+)/(\w+)/(\S+)\.git"
REMOTES_REGEX='(\w+) https'
REMOTES_LIST=$(echo ${REMOTES} | grep -Eo "${REMOTES_REGEX}" | uniq | cut -d ' '  -f 1)

if [[ ! -z ${REMOTES_LIST} ]] 
then
	for REMOTE in ${REMOTES_LIST}
	do
		# Generate ssh address for remote
		REGEX=${REMOTE}"\s${HTTPS_REGEX}\s\(fetch\)"

		if [[ ${REMOTES} =~ ${REGEX} ]]
		then
			DOMAIN=${BASH_REMATCH[1]}
			USER_NAME=${BASH_REMATCH[2]}
			REPO=${BASH_REMATCH[3]}
			SSH_REMOTE=git@${DOMAIN}:${USER_NAME}/${REPO}.git

			# Set remote url
			SET_SSH_REMOTE="git remote set-url ${REMOTE} ${SSH_REMOTE}"
			echo ${REMOTE} set to ${SSH_REMOTE}
			$(${SET_SSH_REMOTE})
		fi
	done
else
	echo "No https remotes found"
fi

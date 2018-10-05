# Convert git repo from using HTTPS to ssh

REMOTES=$(git remote -v)
HTTP_REGEX="https://(\S+)/(\w+)/(\S+)\.git"
for REMOTE in origin upstream
do
	# Generate ssh address for remote
	REGEX=$REMOTE"\s${HTTP_REGEX}\s\(fetch\)"

	if [[ $REMOTES =~ $REGEX ]]
	then
		HTTP_REMOTE=${BASH_REMATCH[1]}
		DOMAIN=${BASH_REMATCH[1]}
		USER_NAME=${BASH_REMATCH[2]}
		REPO=${BASH_REMATCH[3]}
		SSH_REMOTE=git@${DOMAIN}:${USER_NAME}/${REPO}.git

		# Set remote url
		SET_SSH_REMOTE="git remote set-url ${REMOTE} ${SSH_REMOTE}"
		echo ${REMOTE} set to ${SSH_REMOTE}
		$(${SET_SSH_REMOTE})
	else
		# Logic is wrong.
		# This prints if remote doesn't exist, or if it uses ssh already.
		echo ${REMOTE} already uses ssh
	fi
done

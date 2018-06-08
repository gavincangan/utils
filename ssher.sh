#!/bin/bash

# Args
# [numbers]: select appropriate server and ssh into it
# help: print help

SCRIPT_NAME="$0"
ARGS="$@"
NEW_FILE="/tmp/ssher.sh"
VERSION="1.1"

check_upgrade() {
	[ -f "$NEW_FILE" ] && {
		echo "Found a new version of me, updating myself..."
    	cp "$NEW_FILE" "$SCRIPT_NAME"
    	rm -f "$NEW_FILE"

    	echo "Running the new version..."
    	$SCRIPT_NAME $ARGS

    	exit 0
    }

    echo "I'm VERSION $VERSION, already the latest version."
}

main()	{
	echo "Hello World! I'm version $VERSION of the script"
}

check_upgrade
main

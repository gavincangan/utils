#!/bin/bash

# Arguments:
# [numbers]: select appropriate server and ssh into it
# help: print help
# ['update' feature is a work in progress] update <new-SSH-string> <name-of-new-server>

SCRIPT_NAME="$0"
ARGS="$@"
NEW_FILE="/tmp/ssher.sh"
TEMP_NEW_FILE="/tmp/ssher_temp.sh"
VERSION=0

MAXNUM=7

print_help() {
    echo "1 CAS-GPU"
    echo "2 CAS lab"
    echo "3 Discovery"
    echo "4 Adam"
    echo "5 Pegasus"
    echo "6 Huckleberry"
    echo "7 New River"
    echo "8 Cascades"
    # end_help
}

check_upgrade() {
    [ -f "$NEW_FILE" ] && {
        echo "Found a new version. Updating myself..."
        cp "$NEW_FILE" "$SCRIPT_NAME"
        rm -f "$NEW_FILE"

        # echo "Running the new version..."
        # $SCRIPT_NAME $ARGS

        exit 0
    }

    echo "Version $VERSION: already at the latest version."
}

update_script(){
    cp "$SCRIPT_NAME" "$NEW_FILE" -f
    NEW_MAXNUM=$(expr $MAXNUM + 1)
    NEW_VERSION=$(expr $VERSION + 1)
    echo $NEW_VERSION
    echo $NEW_MAXNUM
    echo $NEW_FILE
    sed -e 's/VERSION='"$VERSION"'/VERSION='"$NEW_VERSION"'/g' $NEW_FILE > $TEMP_NEW_FILE
    cp "$TEMP_NEW_FILE" "$NEW_FILE" -f

    sed -e 's/MAXNUM='"$MAXNUM"'/MAXNUM='"$NEW_MAXNUM"'/g' $NEW_FILE > $TEMP_NEW_FILE
    cp "$TEMP_NEW_FILE" "$NEW_FILE" -f

    rm -f "$TEMP_NEW_FILE"
    # sed -n 'p; s/\['"$MAXNUM"'\]*/\['"$NEW_MAXNUM"'\]/p' $NEW_FILE > $TEMP_NEW_FILE

    check_upgrade
}

main()    {
    echo "SSHer version $VERSION"
    case $ARGS in

    [0]*)
        my_ssh_string="gavincangan@casgpu.bgav.in"
        ;;

    [1]*)
        my_ssh_string="bgavin@caslab.ece.vt.edu"
        ;;

    [2]*)
        my_ssh_string="bgavin@discovery1.bi.vt.edu"
        ;;

    [3]*)
        my_ssh_string="bgavin@adam.bi.vt.edu"
        ;;

    [4]*)
        my_ssh_string="bgavin@pegasus1.bi.vt.edu"
        ;;

    [5]*)
        my_ssh_string="bgavin@huckleberry1.arc.vt.edu"
        ;;

    [6]*)
        my_ssh_string="bgavin@newriver1.arc.vt.edu"
        ;;

    [7]*)
        my_ssh_string="bgavin@cascades1.arc.vt.edu"
        ;;

    update*)
        new_ssh_string=$(echo $ARGS | cut -d' ' -f 2)
        new_server_name=$(echo $ARGS | cut -d' ' -f 3)
        echo "Adding new server..." "$new_server_name" "-->" "$new_ssh_string"

        update_script

        ;;

    *)
        print_help
        ;;

    esac

    case $ARGS in
    [1-$MAXNUM]*)
        echo "I am Groot"
        ssh $my_ssh_string
        echo $MAXNUM
        ;;
    esac
}

    

main

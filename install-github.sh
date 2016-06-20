#!/bin/bash

#Fail this script should any operation fail
set -e
set -o pipefail

# Input variables
##########

declare GITHUB_KEY_EMAIL="";
declare FULL_NAME="";
declare GITHUB_KEY_PASS="";
declare INTERACTIVE_MODE=true;

# Utility functions
##########

function enforce_root {
    if [ "$(whoami)" != "root" ];
    then
        echo "Please re-run this script as root (eg: 'sudo bash <script>')."
        echo "#####"
        exit;
    fi
}

# Checks, user input, and input validation
##########

enforce_root;

while getopts 'e:n:pzh' option
do
    case $option in
        e ) GITHUB_KEY_EMAIL=${OPTARG}; ;;
        n ) FULL_NAME=${OPTARG}; ;;
        z ) INTERACTIVE_MODE=false; ;;
        h ) echo "Help (-h): See readme.md for script arguments and other info."; echo "#####"; exit; ;;
    esac
done

if [ "${GITHUB_KEY_EMAIL}" = "" ];
then
    echo "Please provide an email to tag your SSH key and git commits with (use the '-e \"<string>\"' argument)."
    echo "#####"
    exit;
fi

if [ "${FULL_NAME}" = "" ];
then
    echo "Please provide a full name to tag your git commits with (use the '-n \"<string>\"' argument)."
    echo "#####"
    exit;
fi

echo "If the script seems to have halted here, don't forget to provide a password for your SSH key via standard input."
echo "#####"
read GITHUB_KEY_PASS

echo "This script will install git, configure your name and email for commits, and create a password protected RSA key (in ~/.ssh/id_rsa) to use with GitHub."
echo "#####"

# The config script
##########

echo "Configuring git"
echo "#####"
su - $SUDO_USER -c "
git config --global user.name \"${FULL_NAME}\"
git config --global user.email \"${GITHUB_KEY_EMAIL}\""

echo "Generating SSH key to use with github."
echo "#####"
su - $SUDO_USER -c "
mkdir -p ~/.ssh
chmod 0700 ~/.ssh"
if ! $INTERACTIVE_MODE;
then
    echo "Deleting id_rsa and id_rsa.pub if they already exist."
    echo "#####"
    rm -f ~/.ssh/id_rsa
    rm -f ~/.ssh/id_rsa.pub
fi
su - $SUDO_USER -c "ssh-keygen -t rsa -b 4096 -C \"${GITHUB_KEY_EMAIL}\" -N \"${GITHUB_KEY_PASS}\" -f ~/.ssh/id_rsa"

echo "Done!"
echo "Add the following SSH public key to github:"
echo "#####"
cat ~/.ssh/id_rsa.pub
echo "#####"
echo "-----"

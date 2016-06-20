#!/bin/bash

set -e
set -o pipefail

function enforce_root {
    if [ "$(whoami)" != "root" ];
    then
        echo "Please re-run this script as root (eg: 'sudo bash <script>').";
        echo "#####"
        exit;
    fi
}

enforce_root;

echo "Adding Atom.io Repository"
add-apt-repository ppa:webupd8team/atom -y

echo "Updating Repository"
sudo apt-get update

echo "Installing apt packages..."
apt-get -y install git python3-pip postgresql postgresql-contrib pgadmin3 atom build-essential

echo "All set!"
echo "You can now configure postgresql for local development"

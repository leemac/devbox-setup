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

echo "Installing pip packages"
pip3 install virtualenvwrapper

read -p "Do you want to update your bashrc now for virtualenvwrapper? (Only do this once to prevent duplicates) - Y or n? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo "Updating bashrc for mkvirtualenv"
  echo 'export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3' >> ~/.bashrc
  echo 'export WORKON_HOME=$HOME/.virtualenvs' >> ~/.bashrc
  echo 'export PROJECT_HOME=$HOME/$USER' >> ~/.bashrc
  echo 'source /usr/local/bin/virtualenvwrapper.sh' >> ~/.bashrc
fi

echo "All set!"
echo "You can now configure postgresql for local development"
echo "You must now do source ~/.bashrc to get the latest changes there"

# devbox-setup
This repo contains a few scripts that help me setup my local devbox by installing tools/utilities that I always utilize. Geared toward
Ubuntu-flavored distros. I mostly use Ubuntu and/or Mint.

## Requirements

Basic requirement is git/ssh key setup. I could use curl to get the script and run as root, but that opens up security issues.

## install.sh

Currently installs the following:

- atom.io editor
- Postgresql along with pgadmin3 (and a few other essentials)
- Pip for python3
- tmux
- python3-dev 

Also configures the following:

- virtualenvwrapper bashrc lines

## install-github.sh

Interactive prompt to configure git. Obtained from the inspiration below.

## Inspiration

Many things inspired by https://github.com/cjjeakle/devbox-setup

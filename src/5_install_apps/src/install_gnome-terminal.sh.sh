#!/bin/bash
set -Ceu
#-----------------------------------------------------------------------------
# install_gnome-terminal.sh.sh
# 作成日時: 2019-04-11 16:24:07
#-----------------------------------------------------------------------------
Run() {
	sudo add-apt-repository ppa:gnome3-team/gnome3-staging
	sudo apt-get update -y
	sudo apt-get install -y gnome-terminal
	sudo add-apt-repository -r ppa:gnome3-team/gnome3-staging
}
Run


#!/bin/bash
set -Ceu
#-----------------------------------------------------------------------------
# install_raspi2png.sh
# 作成日時: 2019-03-17 17:00:54
#-----------------------------------------------------------------------------
Run() {
	mkdir -p /tmp/work
	cd /tmp/work
	wget https://github.com/AndrewFromMelbourne/raspi2png/archive/master.zip
	unzip master.zip
	cd raspi2png-master
	make
	sudo cp raspi2png /usr/local/bin
	rm -Rf /tmp/work/raspi2png-master
}
Run

#!/bin/bash
set -Ceu
#-----------------------------------------------------------------------------
# install_font_SPEED.sh
# http://cfont.jp/eijifree/speed.html
# 
# 作成日時: 2019-03-21 15:53:15
#-----------------------------------------------------------------------------
Run() {
	mkdir -p /tmp/work
	cd /tmp/work
	wget http://cfont.jp/downroad/PC_Speed.zip
	unzip PC_Speed.zip
	cd Speed

	mkdir -p ~/.fonts
	cp -a /tmp/work/Speed/*.TTF ~/.fonts
#	cp -a /tmp/work/Speed/SPEED___.TTF ~/.fonts/SPEED___.TTF
#	cp -a /tmp/work/Speed/SPEEDOPE.TTF ~/.fonts/SPEEDOPE.TTF
#	cp -a /tmp/work/Speed/SPEEDSOL.TTF ~/.fonts/SPEEDSOL.TTF
	fc-list | grep 'SPEED'
	# on system
	# cp -a /tmp/Yakitori_winTT/YAKITORI.TTF /usr/local/share/fonts/YAKITORI.TTF
	# sudo fc-cache -fv

}
Run

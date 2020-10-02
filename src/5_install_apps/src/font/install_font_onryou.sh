#!/bin/bash
set -Ceu
#-----------------------------------------------------------------------------
# install_font_onryo.sh
# http://www.ankokukoubou.com/font/onryou.htm
# 作成日時: 2019-03-21 16:25:11
#-----------------------------------------------------------------------------
Onryou() {
	mkdir -p /tmp/work
	cd /tmp/work
	wget http://ftp.vector.co.jp/51/30/3249/onryou.zip
	unzip onryou.zip
	mkdir -p ~/.fonts
	cp -a /tmp/work/onryou.TTF ~/.fonts
	fc-list | grep 'onryou'
}
Hakidame() {
	mkdir -p /tmp/work
	cd /tmp/work
	wget http://ftp.vector.co.jp/50/38/3181/hakidame.zip
	unzip hakidame.zip
	mkdir -p ~/.fonts
	cp -a /tmp/work/hakidame.TTF ~/.fonts
	fc-list | grep 'hakidame'
}
Ankokuzonji() {
	mkdir -p /tmp/work
	cd /tmp/work
	wget http://ftp.vector.co.jp/70/32/3601/ankokuzonji.zip
	unzip ankokuzonji.zip
	mkdir -p ~/.fonts
	cp -a /tmp/work/ankokuzonji/Zomzi.TTF ~/.fonts
	fc-list | grep 'Zomzi'
}
Obake() {
	mkdir -p /tmp/work
	cd /tmp/work
	wget http://www.ankokukoubou.com/font/japanese/obake.zip
	unzip obake.zip
	mkdir -p ~/.fonts
	cp -a /tmp/work/obake.TTF ~/.fonts
	fc-list | grep 'obake'
}
DeathOne() {
	mkdir -p /tmp/work
	cd /tmp/work
	wget http://www.ankokukoubou.com/font/english/DeathOne.zip
	unzip DeathOne.zip
	mkdir -p ~/.fonts
	cp -a /tmp/work/DeathOne.TTF ~/.fonts
	fc-list | grep 'DeathOne'
	# display ~/.fonts/DeathOne.TTF [sudo apt install -y imagemagick]
	
}
Run() {
	Onryou
	Hakidame
	Ankokuzonji
	Obake
	DeathOne
}
Run

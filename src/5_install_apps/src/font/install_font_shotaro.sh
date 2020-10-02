#!/bin/bash
set -Ceu
#-----------------------------------------------------------------------------
# font_install_shotaro.sh
# 作成日時: 2019-03-21 17:26:29
http://mksd.jp/shotaro.html
http://mksd.jp/designfont.html
#-----------------------------------------------------------------------------
Run() {
	mkdir -p /tmp/work
	cd /tmp/work
	wget http://mksd.jp/mksd_shotaro_v3.zip
	unzip mksd_shotaro_v3.zip
	mkdir -p ~/.fonts
	cp -a /tmp/work/mksd_shotaro_v3/ShotaroV-AL.otf ~/.fonts
	cp -a /tmp/work/mksd_shotaro_v3/ShotaroV-KT.otf ~/.fonts
	fc-list | grep 'Shotaro'
}

Run

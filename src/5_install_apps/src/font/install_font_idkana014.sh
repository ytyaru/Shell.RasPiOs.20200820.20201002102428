#!/bin/bash
set -Ceu
#-----------------------------------------------------------------------------
# install_font_idkana014.sh
# http://idfont.jp/free-kanji/free-kana.html
# 作成日時: 2019-03-21 18:30:12
#-----------------------------------------------------------------------------
Run() {
	mkdir -p /tmp/work
	cd /tmp/work
	wget http://idfont.jp/free-kanji/kana_pac2.zip
	wget http://idfont.jp/free-kanji/kana_pac3.zip
	unzip kana_pac2.zip
	unzip kana_pac3.zip
	mkdir -p ~/.fonts
	cp -a /tmp/work/kana014.ttc ~/.fonts/kana014.ttc
	cp -a /tmp/work/kana026.ttc ~/.fonts/kana026.ttc
	fc-list | grep 'kana014'
	display /home/pi/.fonts/kana014.ttc
	fc-list | grep 'kana026'
	display /home/pi/.fonts/kana026.ttc
	rm -Rf kana_pac2.zip
	rm -Rf kana_pac3.zip
}
Run

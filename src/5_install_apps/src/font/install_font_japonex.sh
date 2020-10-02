#!/bin/bash
set -Ceu
#-----------------------------------------------------------------------------
# install_font_japonex.sh
# http://pandachan.jp/strawberry/font/26japonesque.html
# 作成日時: 2019-03-21 18:44:49
#-----------------------------------------------------------------------------
Japonesque() {
	mkdir -p ~/.fonts
	mkdir -p /tmp/work
	cd /tmp/work
	wget http://pandachan.jp/strawberry/david/japonesquewin.zip
	unzip japonesquewin.zip
	cd japonesque149cwin
	cp -a /tmp/work/japonesque149cwin/AK-Japonesque.TTF ~/.fonts/AK-Japonesque.TTF
	fc-list | grep 'じゃぽねすく'
	display ~/.fonts/AK-Japonesque.TTF
	rm -Rf japonesquewin.zip
	rm -Rf japonesque149cwin
}
kouzangyousho() {
	mkdir -p ~/.fonts
	mkdir -p /tmp/work
	cd /tmp/work
	wget http://cute-freefont.flop.jp/dl/kouzangyousho.zip
	unzip kouzangyousho.zip
	cd kouzangyousho
	cp -a /tmp/work/kouzangyousho/KouzanGyoushoOTF.otf ~/.fonts
	fc-list | grep 'KouzanGyousho'
	display ~/.fonts/KouzanGyoushoOTF.otf
	rm -Rf kouzangyousho.zip
	rm -Rf kouzangyousho
}
ZInFree_Henawin() {
	mkdir -p ~/.fonts
	mkdir -p /tmp/work
	cd /tmp/work
	wget http://cute-freefont.flop.jp/ZInFree_Henawin.rar
	unrar -y x ZInFree_Henawin.rar	
	cp -a /tmp/work/ZInFree_Henawin/ZinHena-MK.otf ~/.fonts
	fc-list | grep 'ZinHena'
	rm -Rf ZInFree_Henawin.rar
	rm -Rf ZInFree_Henawin
}
Run() {
	Japonesque
	kouzangyousho
	ZInFree_Henawin
}
Run

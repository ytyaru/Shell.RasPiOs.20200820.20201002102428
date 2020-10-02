#!/bin/bash
set -Ceu
#-----------------------------------------------------------------------------
# install_font_YAKITORI.sh
# ひらがな、カタカナ、英数字、記号のみ。
# 作成日時: 2019-03-21 15:41:48
#-----------------------------------------------------------------------------
Run() {
	mkdir -p /tmp/work
	cd /tmp/work
	wget http://mksd.jp/Yakitori_winTT.zip
#	tar xf Yakitori_winTT.zip
	unzip Yakitori_winTT.zip
	cd Yakitori_winTT
	mkdir -p ~/.fonts
	cp -a /tmp/work/Yakitori_winTT/YAKITORI.TTF ~/.fonts/YAKITORI.TTF
	fc-list | grep 'YAKITORI'
	# on system
	# cp -a /tmp/Yakitori_winTT/YAKITORI.TTF /usr/local/share/fonts/YAKITORI.TTF
	# sudo fc-cache -fv
}
Run

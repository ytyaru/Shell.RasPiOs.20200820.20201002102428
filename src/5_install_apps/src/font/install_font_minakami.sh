#!/bin/bash
set -Ceu
#-----------------------------------------------------------------------------
# install_font_minakami.sh
# http://mksd.jp/minakami.html
# 群馬県温泉地フォントシリーズ第4弾です。群馬の名湯「水上温泉」をイメージしながら、ほっこり感満載かつ、雑なタッチで表現した、2バイトのオープンタイプフォントです。お品書きやちょっとした見出し、擬音表現などに重宝するでしょう。漢字は「温・泉・地・水・上」のみ打ち出せます（笑）また、「鳥・達磨・鶴・群馬・板・太陽・兎・目・眼鏡・湯・杖・絞・山・団・靴・星・丸・四角・三角」と打つと絵文字が表示されます。
# 作成日時: 2019-03-21 16:58:49
#-----------------------------------------------------------------------------
Run() {
	mkdir -p /tmp/work
	cd /tmp/work
	wget http://mksd.jp/minakami_otf.zip
	unzip minakami_otf.zip
	mkdir -p ~/.fonts
	cp -a /tmp/work/minakami_otf/Minakami-Medium.otf ~/.fonts
	fc-list | grep 'Minakami'
	# sudo apt install imagemagick
	# display /tmp/work/minakami_otf/Minakami-Medium.otf
}
Run

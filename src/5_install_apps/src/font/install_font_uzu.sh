#!/bin/bash
set -Ceu
#-----------------------------------------------------------------------------
# install_font_uzu.sh
# http://www.geocities.jp/o030b/ainezunouzu/
# ○ 半角英数　　○ 記号　　○ 英数字　　○ ひらがな　　○ カタカナ
# ○ ギリシャ文字　　○ ロシア文字　　× 罫線素片　　○ 囲み英数字　　○ アラビア数字
# ○ 単位記号　　○ 省略文字　　○ 囲み文字　　○ 年号　　○ 数学記号
# △ JIS第一水準漢字　　× JIS第二水準漢字　　× IBM拡張漢字
# 作成日時: 2019-03-21 20:19:50
#-----------------------------------------------------------------------------
Run() {	
	mkdir -p /tmp/work
	cd /tmp/work
	wget http://www.geocities.jp/o030b/ainezunouzu/font/fil13/uzu-fude.zip
	unzip uzu-fude.zip
	# 文字化けして自動化できない……
	cp -a /tmp/work/uzu-fude.ttf ~/.fonts
	fc-list | grep 'uzu'
#	rm -Rf uzu-fude.zip
#	display ~/.fonts/uzu-fude.ttf
}
Run

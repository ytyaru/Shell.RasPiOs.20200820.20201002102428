#!/bin/bash
set -Ceu
#-----------------------------------------------------------------------------
# install_font_nikumaru.sh
# http://www.fontna.com/blog/1651/
# 作成日時: 2019-03-21 18:13:25
#-----------------------------------------------------------------------------
Run() {
	mkdir -p /tmp/work
	cd /tmp/work
	wget http://bgmsound.sakura.ne.jp/fontna/NikumaruFont.zip
	unzip NikumaruFont.zip
	cd NikumaruFont
	# 文字化けして自動化できない……
	# 文字コードを変換しようにも出力がおかしい
	# `バイナリファイル (標準入力) に一致しました`
	#ls -1 | grep '.*.otf'
	#find . -type f -name '*.otf' | iconv --help -f sjis -t utf8
	# pcmanfm（GUIファイラ）により手動でファイル名を編集した。
	cp -a /tmp/work/NikumaruFont/NikumaruFont.otf ~/.fonts
	fc-list | grep 'NikumaruFont'
}
Run

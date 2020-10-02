#!/bin/bash
set -Ceu
#-----------------------------------------------------------------------------
# install_font_LightNovelPOP.sh
# http://www.fontna.com/blog/1706/
# 作成日時: 2019-03-21 17:50:31
#-----------------------------------------------------------------------------
Run() {
	mkdir -p /tmp/work
	cd /tmp/work
	wget http://bgmsound.sakura.ne.jp/fontna/LightNovelPOP_FONT.zip
	unzip LightNovelPOP_FONT.zip
	cd LightNovelPOP_FONT
	# 文字化けして自動化できない……
	# 文字コードを変換しようにも出力がおかしい
	# `バイナリファイル (標準入力) に一致しました`
	#ls -1 | grep '.*.otf'
	#find . -type f -name '*.otf' | iconv --help -f sjis -t utf8
#	cp -a /tmp/work/LightNovelPOP_FONT/���m�xPOP.otf /tmp/work/LightNovelPOP_FONT/LightNovelPOP.otf
#	mkdir -p /tmp/work/LightNovelPOP_FONT/full
#	cp -a /tmp/work/LightNovelPOP_FONT/���̑�-�T�|�[�g�O/���m�xPOP.ttf /tmp/work/LightNovelPOP_FONT/full/LightNovelPOP.otf 
	cp -a /tmp/work/LightNovelPOP_FONT/LightNovelPOP.otf ~/.fonts/LightNovelPOP.otf	fc-list | grep 'LightNovelPOP'
}
Run

#!/bin/bash
set -Ceu
#-----------------------------------------------------------------------------
# CSV(TSV)ファイルをSQL操作するPython製ツールqをインストールする。
# 作成日時: 2019-03-16 17:34:40
# https://github.com/harelba/q
#-----------------------------------------------------------------------------
Run() {
	sudo wget git.io/trans -O /usr/local/bin/trans
	sudo chmod +x /usr/local/bin/trans
	sudo apt -y install gawk libfribidi-bin mplayer
#	trans -b en:ja 'The earthquake struck the southern coast of Mexico on 7 September 2017.'
#	trans -b -p en:ja 'The earthquake struck the southern coast of Mexico on 7 September 2017.'
#	trans -b -p -e bing ja:en 'Google翻訳だけでなくBing翻訳も使える。'
}
Run

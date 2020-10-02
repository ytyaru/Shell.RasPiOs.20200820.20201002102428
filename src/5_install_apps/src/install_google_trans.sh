#!/bin/bash
set -Ceu
#-----------------------------------------------------------------------------
# Google翻訳するCLIをインストールする。
# 作成日時: 2020-10-02
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

#!/bin/bash
set -Ceu
#-----------------------------------------------------------------------------
# install_highlight.sh
# 作成日時: 2019-03-17 17:00:54
#-----------------------------------------------------------------------------
Run() {
	sudo apt install -y highlight
	# 最新は3.49。だがaptは古く3.18しかない。この場合markdown,json,yaml用シンタックス定義ファイルがないため、それらの言語がハイライトされない。そこでgithubから最新定義ファイル一式をダウンロードする。
	mkdir -p /tmp/work
	cd /tmp/work
	git clone https://github.com/andre-simon/highlight
	cd highlight
	sudo cp -Ra /tmp/work/highlight/langDefs/* /usr/share/highlight/langDefs/
	sudo cp -Ra /tmp/work/highlight/themes/* /usr/share/highlight/themes/
	rm -Rf /tmp/work/highlight
#	以下コマンドで定義ファイルが存在することを確認する
#	highlight --list-langs | grep 'md'
#	highlight --list-langs | grep 'json'
#	highlight --list-langs | grep 'yaml'
}
Run

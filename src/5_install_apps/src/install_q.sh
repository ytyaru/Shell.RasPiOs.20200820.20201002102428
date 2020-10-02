#!/bin/bash
set -Ceu
#-----------------------------------------------------------------------------
# CSV(TSV)ファイルをSQL操作するPython製ツールqをインストールする。
# 作成日時: 2019-03-16 17:34:40
# https://github.com/harelba/q
#-----------------------------------------------------------------------------
Run() {
	local filename="q-text-as-data_1.7.1-2_all.deb"
	cd /tmp/work
	wget "https://raw.githubusercontent.com/harelba/packages-for-q/master/deb/${filename}"
	# アンインストールするとき: sudo dpkg -r q
	sudo dpkg -i "${filename}"
▸---# --save-to-disk-method 
	# --save-db-to-disk-method オンメモリ保存して高速化する
	pip install sqlitebck
}
Run

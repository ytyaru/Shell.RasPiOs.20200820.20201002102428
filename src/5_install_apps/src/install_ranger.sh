#!/bin/bash
set -Ceu
#-----------------------------------------------------------------------------
# install_ranger.sh
# 作成日時: 2019-03-16 12:53:39
#-----------------------------------------------------------------------------
Install() {
	# 罠
	# * apt, pip, どちらもスペース区切りで複数やると勝手に途中で終了することがある。1個ずつやること。
	# * 実行コマンド名とインストール名が異なるものがある。`pip search ranger-fm`などでパッケージ名を検索して見つけること。

#	pip3 install ranger-fm Pygments lynx elinks atool unrar-free pymediainfo xpdf-python chardet img2txt
#	pip install ranger-fm Pygments lynx elinks atool unrar pymediainfo xpdf-python chardet img2txt
	sudo pip3 install ranger-fm
#	sudo pip3 install Pygments
#	sudo pip3 install pyhighlight
	sudo pip3 install lynx
	sudo pip3 install elinks
	sudo pip3 install atool
	sudo pip3 install unrar
	sudo pip3 install pymediainfo
	sudo pip3 install xpdf-python
	sudo pip3 install chardet
	sudo pip3 install img2txt

#	sudo apt install -y xsel w3m xpdf caca-utils
#	sudo apt install -y xsel exiftool mediainfo w3m pdftotext mutool caca-utils ImageMagick
	sudo apt install -y xsel
	sudo apt install -y exiftool
	sudo apt install -y mediainfo
	sudo apt install -y w3m
	sudo apt install -y highlight

	#E: パッケージ pdftotext が見つかりません
	# Debianでは xpdf という名前でインストールする。実行コマンド名は pdftotext
#	sudo apt install -y pdftotext
	sudo apt install -y xpdf
#	sudo apt install -y mutool
	#E: パッケージ mutool が見つかりません
	# $ apt search mutool
	# mupdf-tools/stable,stable,stable,stable,stable 1.9a+ds1-4+deb9u4 armhf
	#   command line tools for the MuPDF viewer
	sudo apt install -y mupdf-tools
	sudo apt install -y caca-utils
	sudo apt install -y imagemagick
	sudo apt install -y ffmpegthumbnailer
	# 画像表示に対応したターミナル
	sudo apt install -y terminology

	# Linux.Debian.Raspbianでは存在しないものがいくつかある
	# 注意、'exiftool' の代わりに 'libimage-exiftool-perl' を選択します
	# E: パッケージ pdftotext が見つかりません
	# E: パッケージ mutool が見つかりません
	# $ exiftool
	# bash: exiftool: コマンドが見つかりません
	# img2txtはcaca-utilsに含まれているはずなのにない。
	# $ img2txt
	# bash: img2txt: コマンドが見つかりません

	# すべてaptで入れるときは以下。（欠点: 1. 最新版ではない 2. unrarはビルド必要のため入れられない 注意: 1. 一部別物(pygments:highlight) 2. 一部名前が違う(img2txt:caca-utils)）
	# sudo apt install -y ranger w3m lynx highlight atool mediainfo xpdf caca-utils
	# ranger ハイライト設定 /home/pi/.config/ranger/scope.sh は Pygments でなく highlight。highlightはpipにない。pyhighlightがそれかと思ったが違った。
	# 変数: HIGHLIGHT_STYLE='pablo'
	# highlight --list-themes
	# http://www.andre-simon.de/doku/highlight/en/theme-samples.php
	# ターミナルの色は通常8色のみ。
	# $ tput colors
	# 8
	# これを256色にするには以下。
	# $ export TERM=xterm-256color
	# $ tput colors
	# 256
#	sudo apt install -y highlight
}
Setup() {
	[[ -f ~/.config/ranger/rc.conf ]] && echo "設定ファイルは既存のため終了します。"; exit;

	# rangerの設定ファイル出力
	ranger --copy-config=all

	# rc.confの設定
	rcconf=~/.config/ranger/rc.conf
	sed -i -e 's/^set draw_borders .*$/set draw_borders both/g' "${rcconf}"
	sed -i -e 's/^set preview_images .*$/set preview_images true/g' "${rcconf}"
	sed -i -e 's/^set show_hidden .*$/set show_hidden true/g' "${rcconf}"

	# rifle.confの設定
	local rifle=~/.config/ranger/rifle.conf
	targets=$(cat << 'EOS'
ext py  = python -- "$1"
ext pl  = perl -- "$1"
ext rb  = ruby -- "$1"
ext js  = node -- "$1"
ext sh  = sh -- "$1"
ext php = php -- "$1"
EOS
)
	echo "$targets" | ( while read target; do sed -i -e 's/^'"${target}"'$/'"${target}"' | less/g' "${rifle}"; done;)
	#echo "$targets" | ( while read target; do echo "$target" | sed -e 's/^'"${target}"'$/'"${target}"' | less/g'; done;)

	# ~/.bashrcに256色にする設定がなければ追記
	append='export TERM=xterm-256color'
	[[ -z $(cat ~/.bashrc | grep "^${append}$") ]] && echo "$append" >> ~/.bashrc
	#   サブシェルのネスト防止（`S`でサブシェル起動したらネストしないよう`exit`で終了する。）
	#   表示継続（`du`コマンド等は一瞬で表示が消えてしまい役に立たない。これを回避する）
	append='ranger() { [ -n "$RANGER_LEVEL" ] && exit || LESS="$LESS -+F -+X" command ranger "$@"; }'
	[[ -z $(cat ~/.bashrc | grep "^${append}$") ]] && echo "$append" >> ~/.bashrc
	#   `S`でrangerのサブシェルに入ったらプロンプト表示に(ranger)と表示する
	append='[ -n "$RANGER_LEVEL" ] && PS1="(RANGER) $PS1"'
	[[ -z $(cat ~/.bashrc | grep "^${append}$") ]] && echo "$append" >> ~/.bashrc
}
Run() {
	Install
	Setup
}
Run


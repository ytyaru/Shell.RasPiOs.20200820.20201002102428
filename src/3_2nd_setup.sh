#!/usr/bin/env bash
set -Ceu
#---------------------------------------------------------------------------
# 最低限の環境を整える。
#   1. スワップ拡張
#   2. RAMディスク設定
#   3. aptのソースを日本サーバに設定
#   4. システム更新
#   5. 日本語フォント＋日本語入力のインストール
# CreatedAt: 2020-10-02
#---------------------------------------------------------------------------
Run() {
	THIS="$(realpath "${BASH_SOURCE:-0}")"; HERE="$(dirname "$THIS")"; PARENT="$(dirname "$HERE")"; THIS_NAME="$(basename "$THIS")"; APP_ROOT="$PARENT";
	cd "$HERE"
	# コマンドをsudo権限で実行する。 $1: some linux command.
	run_sudo() { sudo sh -c "${1}"; }
	# 指定したテキストを指定したファイルに追記する
	# $1: text: new line text.
	# $2: file: target file path.
	write_line() {
		for i in "${1}"; do
			local command="echo '${i}'"
			sudo sh -c "${command} >> \"${2}\""
		done
	}
	# 指定ファイルのうち先頭が指定テキストの場合、先頭に#を付与する
	# $1: file: target file path.
	# $2: text: target text（ヒアドキュメントで複数行指定されることを想定）
	write_sharp() {
		#IFS_backup=IFS
		#IFS=$'\n'
		for i in ${2}; do
			# 末尾の改行を除去（しないと次のエラーが出る。"sed: -e expression #1, char 2: アドレスregexが終了していません"）
			local line=`echo ${i} | sed -e "s/[\r\n]\+//g"`
			local sed_script="/^${line}/s/^/#/"
			local sed_cmd="sed -e \"${sed_script}\" -i.bak \"${1}\""
			run_sudo "${sed_cmd}"
		done
		#IFS=IFS_backup
	}
	# スワップのサイズを100MBから2GBに変更する
	setup_swap() {
		local SwapFilePath=/etc/dphys-swapfile
		write_sharp "${SwapFilePath}" "CONF_SWAPSIZE=100"
		write_line "CONF_SWAPSIZE=2048" "${SwapFilePath}"
		sudo systemctl stop dphys-swapfile
		sudo systemctl start dphys-swapfile
	}
	# RAMディスク作成（SDカード書込上限対策）
	write_fstab() {
		IsFinished() { cat /etc/fstab | grep -Ec '^tmpfs\s+/tmp'; }
		IsFinished && return
		readonly TEXT="$(cat <<-EOS
			tmpfs /tmp            tmpfs   defaults,size=2048m,noatime,mode=1777      0       0
			tmpfs /var/tmp        tmpfs   defaults,size=16m,noatime,mode=1777      0       0
			tmpfs /var/log        tmpfs   defaults,size=32m,noatime,mode=0755      0       0
			tmpfs /home/pi/.cache/chromium/Default/  tmpfs  defaults,size=2048m,noatime,mode=1777  0  0
			tmpfs /home/pi/.cache/lxsession/LXDE-pi  tmpfs  defaults,size=1m,noatime,mode=1777  0  0
			EOS
		)"
		write_line "${TEXT}" "/etc/fstab"
	}
	# システム更新の高速化（日本用）
	write_apt_sources_list() {
		readonly TEXT="$(cat <<-EOS
			deb http://ftp.jaist.ac.jp/raspbian/ buster main contrib non-free rpi
			deb http://raspbian.raspberrypi.org/raspbian/ buster main contrib non-free rpi
			# Uncomment line below then 'apt-get update' to enable 'apt-get source'
			#deb-src http://raspbian.raspberrypi.org/raspbian/ buster main contrib non-free rpi
			EOS
		)"
		sudo cp /etc/apt/sources.list /etc/apt/sources_"$(date +%Y%m%d%H%M%S)".list
		rm -f /etc/apt/sources.list
		write_line "${text}" "/etc/apt/sources.list"
	}
	# システム＆ファームウェア更新
	update_system() {
		sudo apt update -y
		sudo apt full-upgrade -y
#		sudo apt update -y
#		sudo apt upgrade -y
#		sudo apt dist-upgrade -y
	}
	# 日本語化
	install_japanese() {
		sudo apt install -y fonts-vlgothic fonts-ipafont fonts-ipaexfont
		sudo apt install -y fcitx-mozc
	}
	# 音声をラズパイ本体のイヤホンジャックから出力させる方法: タスクバーの音量アイコンを右クリックして`Analog`を選択する。
	
	setup_swap
	write_fstab
	write_apt_sources_list
	update_system
	install_japanese
}
Run "$@"

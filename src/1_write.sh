#!/usr/bin/env bash
set -Ceu
#---------------------------------------------------------------------------
# RaspberryPiOS 2020-08-20版をデバイスに書き込む。
#   所要時間:
#     SDカード: 約8分
#     HDD     : 約3分
# CreatedAt: 2020-10-02
#---------------------------------------------------------------------------
Run() {
	THIS="$(realpath "${BASH_SOURCE:-0}")"; HERE="$(dirname "$THIS")"; PARENT="$(dirname "$HERE")"; THIS_NAME="$(basename "$THIS")"; APP_ROOT="$PARENT";
	cd "$HERE"

	echo 'このコードを参考にして手動で行うべき。デバイス名が状況に応じて異なるため。'
	return

	readonly DIR_DL="$HOME/root/tmp/raspbian/20201001"
	readonly URL_OS='https://downloads.raspberrypi.org/raspios_armhf/images/raspios_armhf-2020-08-24/2020-08-20-raspios-buster-armhf.zip'
	readonly NAME_OS=$(basename "$URL_OS")
	# https://www.raspberrypi.org/downloads/raspberry-pi-os/
	readonly URL_RN='http://downloads.raspberrypi.org/raspios_armhf/release_notes.txt'
	readonly SHA_256='9d658abe6d97f86320e5a0288df17e6fcdd8776311cc320899719aa805106c52'

	cd "$DIR_DL"
	# 事前にデバイス(SD,HDD,SSD等)を接続しておく。HDDなら外部電源付のUSBハブで接続すること。
	# df -hでデバイス名を確認する
	df -h
	# ここでは/dev/sdbとする
	readonly TARGET_DEVICE='/dev/sdb'
	umount /dev/sdb1
	umount /dev/sdb2

	# デバイスに書き込む。
	time unzip -p "$NAME_OS" | sudo dd of=/dev/sdb bs=4M conv=fsync
}
Run "$@"

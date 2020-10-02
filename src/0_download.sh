#!/usr/bin/env bash
set -Ceu
#---------------------------------------------------------------------------
# RaspberryPiOS 2020-08-20版をダウンロード＆インストールする。
# CreatedAt: 2020-10-02
#---------------------------------------------------------------------------
Run() {
	THIS="$(realpath "${BASH_SOURCE:-0}")"; HERE="$(dirname "$THIS")"; PARENT="$(dirname "$HERE")"; THIS_NAME="$(basename "$THIS")"; APP_ROOT="$PARENT";
	cd "$HERE"
	readonly DIR_DL="$HOME/root/tmp/raspbian/20201001"
	readonly URL_OS='https://downloads.raspberrypi.org/raspios_armhf/images/raspios_armhf-2020-08-24/2020-08-20-raspios-buster-armhf.zip'
	readonly NAME_OS=$(basename "$URL_OS")
	# https://www.raspberrypi.org/downloads/raspberry-pi-os/
	readonly URL_RN='http://downloads.raspberrypi.org/raspios_armhf/release_notes.txt'
	readonly SHA_256='9d658abe6d97f86320e5a0288df17e6fcdd8776311cc320899719aa805106c52'

	mkdir -p "$DIR_DL"
	cd "$DIR_DL"
	Download() { # 所要時間: 約20分
		sudo apt-get install aria2
		time aria2c -x10 "$URL_OS"
	}
	ShaSum() {
		time wget "$URL_RN"
		time shasum -a 256 2020-08-20-raspios-buster-armhf.zip > sha256_actual.txt
		diff <(echo "$SHA_256") <(cat sha256_actual.txt | cut -f1)
	}

	Download; ShaSum;
}
Run "$@"

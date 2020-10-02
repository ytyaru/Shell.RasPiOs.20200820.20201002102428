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
	echo '===== 初期設定1 ====='
	echo '1. 書き込んだデバイスをラズパイ4Bに接続して初回ブートする(HDDならUSB3.0接続時で約3分。焦らず待つ)'
	echo '2. 初回ブートが完了するとデスクトップが表示される'
	echo '3. デスクトップには初期設定ダイアログが表示される'
	echo '4. 初期設定ダイアログに従って入力する（最後に再起動する）'
	echo '===== 初期設定2 ====='
	echo '1. デスクトップのシステムメニューから"設定"→"Raspberry Pi の設定"を選ぶ'
	echo '2. "インタフェース"タブをクリックする'
	echo '"SSH","VNC"を"有効"にする'
	echo '"OK"ボタンをクリックする'
	echo '===== 注意 ====='
	echo '無線LAN接続できなかった。WiFiドングルを付けたら接続できた。ラズパイ4B本体付属の無線LANデバイスが壊れているのが原因か？'
	return
}
Run "$@"
#!/usr/bin/env bash
set -Ceu
#---------------------------------------------------------------------------
# データ移行する。Chromium
# http://ytyaru.hatenablog.com/entry/2019/12/10/222222
# CreatedAt: 2020-10-02
#---------------------------------------------------------------------------
Run() {
	THIS="$(realpath "${BASH_SOURCE:-0}")"; HERE="$(dirname "$THIS")"; PARENT="$(dirname "$HERE")"; THIS_NAME="$(basename "$THIS")"; APP_ROOT="$PARENT";
	cd "$HERE"

	PATH_XML='lxde-pi-rc_'$(date +%Y%m%d%H%M%S)'.xml'
	cp "$HOME/.config/openbox/lxde-pi-rc.xml" "$HOME/.config/.config/openbox/$PATH_XML" 

	# 移行先のシステムユーザ名とIPアドレスを指定する
	UN=pi
	IP=192.168.11.51
	HM="$HOME"
	rsync -auvzP -e ssh "$HOME/.config/openbox/$PATH_XML" "$UN@$IP":"$HM/.config/openbox"
	# rsyncはシステムパスワードを入力せねば動作しない。
}
Run "$@"

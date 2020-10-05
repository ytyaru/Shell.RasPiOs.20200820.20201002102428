#!/usr/bin/env bash
set -Ceu
#---------------------------------------------------------------------------
# データ移行する。$HOME/.local/share
# Plumaのカラースキーム。
# CreatedAt: 2020-10-04
#---------------------------------------------------------------------------
Run() {
	THIS="$(realpath "${BASH_SOURCE:-0}")"; HERE="$(dirname "$THIS")"; PARENT="$(dirname "$HERE")"; THIS_NAME="$(basename "$THIS")"; APP_ROOT="$PARENT";
	cd "$HERE"
	DOT_FILES="$(cat <<-EOS
		share/gtksourceview-3.0
		EOS
	)"
	# 移行先のシステムユーザ名とIPアドレスを指定する
	export UN=pi
	export IP=192.168.11.51
	export HM="$HOME"
	echo -e "$PROFILE_DIRS" | xargs -L bash -c 'rsync -auvzP -e ssh "$HOME/.local/{}" "$UN@$IP":"$HM"/.local'
	# rsyncはシステムパスワードを入力せねば動作しない。
}
Run "$@"

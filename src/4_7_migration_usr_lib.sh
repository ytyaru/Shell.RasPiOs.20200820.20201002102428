#!/usr/bin/env bash
set -Ceu
#---------------------------------------------------------------------------
# データ移行する。/usr/local/lib
# http://ytyaru.hatenablog.com/entry/2019/12/10/222222
# CreatedAt: 2020-10-02
#---------------------------------------------------------------------------
Run() {
	THIS="$(realpath "${BASH_SOURCE:-0}")"; HERE="$(dirname "$THIS")"; PARENT="$(dirname "$HERE")"; THIS_NAME="$(basename "$THIS")"; APP_ROOT="$PARENT";
	cd "$HERE"
	DOT_FILES="$(cat <<-EOS
		mmdpi
		libHTSEngine.a
		EOS
	)"
	# 移行先のシステムユーザ名とIPアドレスを指定する
	export UN=pi
	export IP=192.168.11.51
	export HM="$HOME"
	echo -e "$PROFILE_DIRS" | xargs -L bash -c 'rsync -auvzP -e ssh "/usr/local/lib/{}" "$UN@$IP":"/usr/local/lib"'
	# rsyncはシステムパスワードを入力せねば動作しない。
	# Permission denied エラーになる
}
Run "$@"

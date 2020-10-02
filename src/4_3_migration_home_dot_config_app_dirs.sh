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
	DOT_FILES="$(cat <<-EOS
		libreoffice
		ranger
		EOS
	)"
	# 移行先のシステムユーザ名とIPアドレスを指定する
	export UN=pi
	export IP=192.168.11.51
	export HM="$HOME"
	echo -e "$PROFILE_DIRS" | xargs -L bash -c 'rsync -auvzP -e ssh "$HOME/.config/{}" "$UN@$IP":"$HM/.config"'
	# rsyncはシステムパスワードを入力せねば動作しない。

	# chromiumのプロファイルを調べる
	python3 -m json.tool "$HOME/.config/chromium/Local State" "$HERE/Local_State_format"
	readonly PROFILE_DIRS="$(jq -r '[ .profile.info_cache | keys ] | flatten | .[]' "$HERE/Local_State_format")"
	readonly PROFILE_NAMES="$(jq -r '.profile.info_cache[].name' "$HERE/Local_State_format")"
	paste <(echo -e "$PROFILE_DIRS") <(echo -e "$PROFILE_NAMES")

	# 移行先でプロファイルを予め作成しておく。
	# （移行元のプロファイルをそのままコピーしても認識されない。原因不明）
	echo '移行先でプロファイルを予め作成しておく。（移行元のプロファイルをそのままコピーしても認識されない。原因不明）手順は以下。'
	echo '1. Chromiumの右上にあるユーザアイコンをクリックする'
	echo '2. ユーザを管理→ユーザを追加'
	echo '3. 上記の通りの順序と名前で作る'

	# 移行先のシステムユーザ名とIPアドレスを指定する
	export UN=pi
	export IP=192.168.11.51
	export HM="$HOME"
	echo -e "$PROFILE_DIRS" | xargs -L bash -c 'rsync -auvzP -e ssh "$HOME/.config/chromium/{}" "$UN@$IP":"$HM/.config/chromium"'

	# rsyncはシステムパスワードを入力せねば動作しない。
}
Run "$@"

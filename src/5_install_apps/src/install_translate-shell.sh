#!/bin/bash
set -Ceu
#-----------------------------------------------------------------------------
# translate-shell.sh
# aptでインストールできるのは0.9.5でバグがある。文章末尾に`null`が付与されてしまう。
# これを避けるため最新コードからビルド・インストールする。
# 作成日時: 2019-03-28
# 確認時バージョン: 0.9.6.9
# https://github.com/soimort/translate-shell
#-----------------------------------------------------------------------------
CaseArchvi() {
	local VERSION=0.9.6.9
	wget "https://github.com/soimort/translate-shell/archive/v${VERSION}.tar.gz"
	tar xf "v${VERSION}.tar.gz"
	cd "translate-shell-${VERSION}"
	sudo apt install -y build-essential checkinstall
	sudo checkinstall -y --fstrans=no --install=no > translate-shell_checkinstall.log
}
CaseGithub() {
	sudo apt install -y build-essential checkinstall
	sudo apt install -y gawk libfribidi-bin mplayer
	cd /tmp/work
	git clone https://github.com/soimort/translate-shell
	cd translate-shell
	sudo checkinstall -y --fstrans=no --install=no > translate-shell_checkinstall.log
}
Run(){
#	CaseArchvi
	CaseGithub
}
Run

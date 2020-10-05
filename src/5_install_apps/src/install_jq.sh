#!/usr/bin/env bash
set -Ceu
#---------------------------------------------------------------------------
# jq
# https://stedolan.github.io/jq/download/
# CreatedAt: 2020-10-04
#---------------------------------------------------------------------------
Run() {
	THIS="$(realpath "${BASH_SOURCE:-0}")"; HERE="$(dirname "$THIS")"; PARENT="$(dirname "$HERE")"; THIS_NAME="$(basename "$THIS")"; APP_ROOT="$PARENT";
	cd "$HERE"


	sudo apt install -y autoconf bison

	git clone https://github.com/stedolan/jq.git
	cd jq
	autoreconf -i
	./configure --disable-maintainer-mode
	make
	sudo make install

}
Run "$@"

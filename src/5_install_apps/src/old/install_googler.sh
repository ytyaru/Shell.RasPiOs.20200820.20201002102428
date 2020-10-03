#!/bin/bash
set -Ceu
#-----------------------------------------------------------------------------
# install_googler.sh
# 作成日時: 2019-03-28 09:48:48
#-----------------------------------------------------------------------------
WorkDir() { echo "/tmp/work"; }
Version() { echo "3.8"; }
Extension() { echo ".tar.gz"; }
TargetCode() { echo "https://github.com/jarun/googler/archive/v$(Version)$(Extension)"; }
Download() {
	mkdir -p "$(WorkDir)"
	cd "$(WorkDir)"
#	wget "$(TargetCode)"
	tar xf "$(basename $(TargetCode))"
	cd "googler-$(Version)"
}
Build() {
	
}
Run() {
	Download
	Build
}
Run

#!/bin/bash
set -Ceu
#-----------------------------------------------------------------------------
# install_googler.sh
# 作成日時: 2020-10-03
#-----------------------------------------------------------------------------
WorkDir() { echo "/tmp/work"; }
Version() { echo "4.2"; }
Extension() { echo ".tar.gz"; }
TargetCode() { echo "https://github.com/jarun/googler/archive/v$(Version)$(Extension)"; }
Download() {
	mkdir -p "$(WorkDir)"
	cd "$(WorkDir)"
	wget "$(TargetCode)"
	tar xf "$(basename $(TargetCode))"
	cd "googler-$(Version)"
}
Build() {
#	sudo make install
	sudo checkinstall -y --fstrans=no --install=no
	sudo dpkg -i googler_4.2-1_armhf.deb
}
Update() { sudo googler -u; }
Run() {
	Download
	Build
	Update
}
Run

#!/bin/bash
set -Ceu
#-----------------------------------------------------------------------------
# install_unrar.sh
# http://ynko.ga/2017/07/unrar.html
# https://www.rarlab.com/rar_add.htm
# 作成日時: 2019-03-21 19:33:48
#-----------------------------------------------------------------------------
Run() {
	mkdir -p /tmp/work
	cd /tmp/work
	wget https://www.rarlab.com/rar/unrar-5.5.0-arm.gz
	gzip -d unrar-5.5.0-arm.gz
	chmod 755 /tmp/work/unrar-5.5.0-arm
	sudo mv unrar-5.5.0-arm /usr/local/bin/.
	cd /usr/local/bin/
	sudo ln -s unrar-5.5.0-arm unrar
	# unrar e some.rar
	rm -Rf unrar-5.5.0-arm.gz
	rm -Rf unrar-5.5.0-arm
}
Run

#!/bin/bash
set -Ceu
#-----------------------------------------------------------------------------
# install_mo.sh
# Created: 2019-04-24T07:47:32+0900
#-----------------------------------------------------------------------------
Install() {
	curl -sSL https://git.io/get-mo -o mo
	chmod +x mo
	sudo mv mo /usr/local/bin/
}
Use() {
	export NAME="山田"
	echo "My name is {{NAME}} ." | mo
}
Run() { Install; }
Run

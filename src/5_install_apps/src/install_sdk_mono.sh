#!/bin/bash
set -Ceu
#-----------------------------------------------------------------------------
# C# SDK MONO をインストールする。
# 作成日時: 2020-10-03
# https://www.mono-project.com/download/stable/#download-lin-raspbian
# https://qiita.com/takanemu/items/be47fbea4c1483776c8f
# https://www.mono-project.com/docs/compiling-mono/linux/
# https://download.mono-project.com/sources/mono/
#-----------------------------------------------------------------------------
Run() {
	sudo apt install apt-transport-https dirmngr gnupg ca-certificates
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
	echo "deb https://download.mono-project.com/repo/debian stable-raspbianbuster main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
	sudo apt update

	sudo apt install mono-devel
#	sudo apt install mono-dbg
#	sudo apt install referenceassemblies-pcl
#	sudo apt install ca-certificates-mono
#	sudo apt install mono-xsp4
}
Run


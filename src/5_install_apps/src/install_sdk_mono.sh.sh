#!/bin/bash
set -Ceu
#-----------------------------------------------------------------------------
# C# SDK MONO をインストールする。
# 作成日時: 2019-03-16 12:49:56
#-----------------------------------------------------------------------------
Run() {
	sudo apt install -y apt-transport-https dirmngr
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
	echo "deb https://download.mono-project.com/repo/debian stable-raspbianstretch main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
	sudo apt install -y mono-devel
}
Run


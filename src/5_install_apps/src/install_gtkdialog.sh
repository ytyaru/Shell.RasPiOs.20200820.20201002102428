#!/bin/bash
set -Ceu
#-----------------------------------------------------------------------------
# install_gtkdialog.sh.sh
# 作成日時: 2019-04-11 06:29:32
#-----------------------------------------------------------------------------
URL_BASE=https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/gtkdialog/
FILE_NAMES='gtkdialog-0.8.3.tar.gz pfeme-0.1.1.tar.gz pfontview-0.1.3.tar.gz playmusic-0.1.8.tar.gz'
Download() {
	[ -z "$(type -p checkinstall)" ] && sudo apt install -y checkinstall
#	sudo apt install -y {build-essential,flex,lex,bison,byacc}  # 開発ツール
	sudo apt install -y {build-essential,flex,bison}  # 開発ツール
	sudo apt install -y {libgtkhtml-4.0-dev,libgtkhtml-editor-4.0-dev}  # Gtk HTML
	sudo apt install -y {libgtkglext1-dev,libgtkdatabox-dev,libgtkhotkey-dev,libgtkmathview-dev}  # Gtk OtherTools
	sudo apt install -y {libgtk-3-dev,libgtk-3-bin,libgtkgl2.0-dev,libgtksourceview2.0-dev,libgtk2.0-cil-dev}  # Gtk2.0 SDK
	sudo apt install -y {libgtksourceview-3.0-dev,libgtk3.0-cil-dev}  # Gtk3.0 SDK
	sudo apt install -y {texinfo,texi2html}
	sudo apt install -y {glade,libglade2-dev,libgladeui-dev,libgtkdatabox-0.9.3-0-libglade}  # Gtk3.0 IDE
	for fname in $FILE_NAMES; do { [ ! -f "$fname" ] && { wget "$URL_BASE$fname"; tar fx "$fname"; rm -Rf "$fname"; } } done;
}
Install() {
	local -r PREFIX='/usr'
	for fname in $FILE_NAMES; do
		cd "${fname%.tar.gz}"
		echo "${fname}: $(pwd)"
		[[ $fname =~ ^gtkdialog* ]] && BuildGtkDialog "${PREFIX}" || BuildAnother "${PREFIX}"
#		[[ $fname =~ ^gtkdialog* ]] && : || BuildAnother "${PREFIX}"
#
#		PREFIX='/usr'
#		export PREFIX='/usr'
#		[[ $fname =~ gtkdialog* ]] && { ./autogen.sh --prefix='/usr'; ./configure --prefix='/usr'; }
#		[[ $fname =~ ^gtkdialog* ]] && : 

#		[[ $fname =~ gtkdialog* ]] && : || sed -ri 's/^PREFIX\?=\/usr\/local/PREFIX=\{PREFIX:\?\/usr\/local\}/g' Makefile
#		sudo make PREFIX='/usr'
#		make PREFIX=/usr install
#		sudo checkinstall -y $([ ! -d doc-pak ] && echo -n '--nodoc' || echo -n '')
		cd ..





#		Makefileの
#		BugCode='PREFIX?=/usr/local'
#		ModCode='PREFIX={PREFIX:?/usr/local}'
#		sed -ri 's/^PREFIX\?=\/usr\/local/PREFIX=\{PREFIX:\?\/usr\/local\}/g' Makefile

#		[[ $fname =~ gtkdialog* ]] && : || PREFIX='/usr'
#		[[ $fname =~ gtkdialog* ]] && : || PREFIX='/usr'

#		[[ $fname =~ gtkdialog* ]] && { ./autogen.sh; ./configure --prefix='/usr'; }
#		[[ $fname =~ gtkdialog* ]] && { ./autogen.sh --prefix='/usr'; }

#		[[ $fname =~ gtkdialog* ]] && { ./autogen.sh --prefix='/usr'; ./configure --prefix='/usr'; } || ./configure --prefix='/usr'
#		[[ $fname =~ gtkdialog* ]] && : || ./configure --prefix='/usr'
#		sudo make
#		env PREFIX='/usr' sudo make


		#checkinstall -y --install=no $([ ! -d doc-pak ] && echo -n '--nodoc' || echo -n '')
		#sudo checkinstall -y --install=no $([ ! -d doc-pak ] && echo -n '--nodoc' || echo -n '')
		#sudo checkinstall -y --prefix '/usr' --install=no $([ ! -d doc-pak ] && echo -n '--nodoc' || echo -n '')
		#sudo checkinstall -y --prefix='/usr' --install=no $([ ! -d doc-pak ] && echo -n '--nodoc' || echo -n '')
		#sudo checkinstall -y --install=no $([ ! -d doc-pak ] && echo -n '--nodoc' || echo -n '')
#		sudo checkinstall -y $([ ! -d doc-pak ] && echo -n '--nodoc' || echo -n '')
		#dpkg -i gtkdialog_0.8.3-1_armhf.deb
#		cd ..
	done;
}
# $1: インストール親ディレクトリ（prefix）
BuildGtkDialog() {
	./autogen.sh --prefix="$1" --enable-gtk3
	./configure --prefix="$1" --enable-gtk3
	sudo make
	sudo checkinstall -y $([ ! -d doc-pak ] && echo -n '--nodoc' || echo -n '')
}
# $1: インストール親ディレクトリ（prefix）
BuildAnother() {
	sudo make PREFIX="$1"
	sudo make PREFIX="$1" install
}
Run() {
	cd /tmp/work
	Download
	Install
}
Run


#!/bin/bash
set -Ceu
#-----------------------------------------------------------------------------
# install_GTK.sh.sh
# 作成日時: 2019-04-11 16:25:34
#-----------------------------------------------------------------------------
Run() {
	sudo apt install -y {libgtkhtml-4.0-dev,libgtkhtml-editor-4.0-dev}  # Gtk HTML
	sudo apt install -y {libgtkglext1-dev,libgtkdatabox-dev,libgtkhotkey-dev,libgtkmathview-dev}  # Gtk OtherTools
	sudo apt install -y {libgtkgl2.0-dev,libgtk2.0-cil-dev,libgtksourceview2.0-dev}  # Gtk2.0 SDK
	sudo apt install -y {libgtk-3-dev,libgtk-3-bin,libgtksourceview-3.0-dev,libgtk3.0-cil-dev}  # Gtk3.0 SDK
	sudo apt install -y {glade,libglade2-dev,libgladeui-dev,libgtkdatabox-0.9.3-0-libglade}  # Gtk3.0 IDE
}
Run

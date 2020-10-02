#!/bin/bash
set -Ceu
#-----------------------------------------------------------------------------
# install_vim.sh
# クリップボードが使えるvimをビルド＆インストールする。
#   `sudo apt install -y vim`でインストールしたvimはクリップボードが使えない。
#   `vim --version | grep 'clipboard'`で調べると`-clipboard`となっている。これが`+clipboard`である必要がある。
#   そのためにはソースコードからビルドオプションを指定してビルドしてやる必要がある。
# 作成日時: 2019-03-18 09:25:50
# 確認時バージョン: vim 8.1.1017 2019-03-18 https://github.com/vim/vim
# http://note.kurodigi.com/vim-selfbuild/
#-----------------------------------------------------------------------------
# ビルドに必要なツールをインストールする
InstallBuildTools() {
	# build-depを使ってビルドツールをインストールしようとしたが失敗した（E: sources.list に 'ソース' URI を指定する必要があります）
	# `sudo apt build-dep`で開発ツールをインストールするために`deb-src`のコメントアウトを解除する
	# sudo sed -i -e 's/#deb-src /deb-src /g' /etc/apt/sources.list
	# ビルドツールをインストールする
	# sudo apt build-dep vim
	# `deb-src`がないと次のエラーが出る。 E: sources.list に 'ソース' URI を指定する必要があります
	# それでもダメな場合は直接指定がある。今回はダメだった。
	# `deb-src`をコメントアウトする
	# sed -i -e 's/deb-src /#deb-src /g' /etc/apt/sources.list

	# build-depを使わずにビルドツールをインストールするなら以下。
	sudo apt install -y git gettext libtinfo-dev libacl1-dev libgpm-dev build-essential
	# gvimをビルドするなら以下も。
	# sudo apt install -y libxmu-dev libgtk2.0-dev libxpm-dev
	# perl, python, python3, ruby拡張を使うなら以下も。
	sudo apt install -y libperl-dev python-dev python3-dev ruby-dev
	# Lua拡張を使うなら以下も。（バージョンは`apt search lua[0-9]+.+`で検索して最新を使う）
	# 最新は`lua5.3 liblua5.3-dev`だったがこれを入れて`sudo ./configure ...`すると以下のように怒られる。vimで参照するのは5.1らしい。LuaJITのほうが5.1だから？ LuaJITの最新は5.1。
	# checking if lua.h can be found in /usr/include/lua5.1... no
	# configure: error: could not configure lua
	sudo apt install -y lua5.1 liblua5.1-dev
	# LuaJITのLua拡張を使うなら以下も。（バージョンは`apt search luajit`で検索して最新を使う）
	sudo apt install -y luajit libluajit-5.1
	# Tcl/Tk拡張を使うなら以下も。
	sudo apt install -y tk tk-dev tcl tcl-dev

	# ソースコード修正するなら以下も。
	# sudo apt install -y autoconf automake cproto
}
Download() {
	mkdir -p /tmp/work
	cd /tmp/work
	git clone https://github.com/vim/vim.git
	cd vim
}
Build() {
	cd /tmp/work/vim
	# +clipboard
	# https://qiita.com/Nikkely/items/7bfa4e71a6eb1e3d7bed
	# ` --with-luajit`からは独自に追加したもの
	sudo ./configure --with-features=huge \
	 --with-x \
	 --enable-multibyte \
	 --enable-luainterp=dynamic \
	 --enable-gpm \
	 --enable-cscope \
	 --enable-fontset \
	 --enable-fail-if-missing \
	 --prefix=/usr/local \
	 --enable-pythoninterp=dynamic \
	 --enable-python3interp=dynamic \
	 --enable-rubyinterp=dynamic \
	 --enable-gui=auto \
	 --enable-gtk2-check \
	 --with-luajit \
	 --enable-perlinterp=dynamic \
	 --enable-tclinterp=dynamic \
	 --enable-terminal
	sudo make
	/tmp/work/vim/src/vim --version
	# インストールはしない。Debパッケージ作成してインストールするから
#	sudo make install
}
# Debパッケージ化する
Package() {
	cd /tmp/work/vim
	# Debパッケージ作成ツールcheckinstallをインストールする
	sudo apt install -y build-essential checkinstall
	# http://note.kurodigi.com/debpackage/
	# https://sites.google.com/site/teyasn001/ubuntu-13-04/checkinstall
	local log=$(sudo checkinstall -y --fstrans=no --install=no)
#	sudo dpkg -i "${pkgname}"
	# ログの最後のほうに`dpkg -i vim_20190318-1_armhf.deb`のようにファイル名とインストールコマンドが出る。これを抜き出して実行する。
#	eval $(echo "$log" | tail -n 12 | grep 'dpkg -i ')
	# と思ったが、勝手にインストールされていた
	# vim --version

# https://teratail.com/questions/55920
# tar: ./READMEdir/vimdir.info: write 不能: デバイスに空き領域がありません
# /tmp, /var/tmp, /var/logのサイズを増やすと解決する
# $ sudo leafpad /etc/fstab
# tmpfs /tmp            tmpfs   defaults,size=1024m,noatime,mode=1777      0       0
# tmpfs /var/tmp        tmpfs   defaults,size=128m,noatime,mode=1777      0       0
# tmpfs /var/log        tmpfs   defaults,size=128m,noatime,mode=0755      0       0
# それでもダメなら再起動してからcheckinstallし直すと成功する
	# 言語拡張を使うにはvimプラグインを導入する必要がある。
	# LSP(Language Server Protocol)
	#   コードエディタの便利機能。自動補完、定義ジャンプ、ドキュメントのホバー表示など。
	# https://kashewnuts.github.io/2019/01/28/move_from_jedivim_to_vimlsp.html
	# https://kashewnuts.github.io/2018/08/22/jedivim_memo.html
}
ColorScheme() {
	mkdir ~/.vim
	cd ~/.vim
	mkdir colors
	#ColorScheme_murphy
	ColorScheme_molokai
	#ColorScheme_moonfly
}
ColorScheme_murphy() {
	# デフォルトならmurphyが見やすい
	[[ -z $(cat ~/.vimrc | grep '^colorscheme .*$') ]] && echo 'colorscheme murphy' >> ~/.vimrc || sed -i -e 's/^colorscheme .*$/colorscheme murphy/g' ~/.vimrc
}
ColorScheme_molokai() {
	# molokaiインストール
	cd /tmp/work
	git clone https://github.com/tomasr/molokai
	mv /tmp/work/molokai/colors/molokai.vim ~/.vim/colors/
	rm -Rf /tmp/work/molokai
	#sed -i -e 's/^colorscheme .*$/colorscheme molokai/g' "~/.vimrc"
	[[ -z $(cat ~/.vimrc | grep '^colorscheme .*$') ]] && echo 'colorscheme molokai' >> ~/.vimrc || sed -i -e 's/^colorscheme .*$/colorscheme molokai/g' ~/.vimrc
	# molokai.vimのコメントが暗すぎる。以下のように変更
	# "   hi Comment         ctermfg=59
	#    hi Comment         ctermfg=245
}
ColorScheme_moonfly() {
	# moonflyインストール
	# https://github.com/bluz71/vim-moonfly-colors
	# http://colorswat.ch/vim/schemes/moonfly
	git clone https://github.com/bluz71/vim-moonfly-colors
	mv /tmp/work/vim-moonfly-colors/colors/moonfly.vim ~/.vim/colors/
	mv /tmp/work/vim-moonfly-colors/autoload/**/* ~/.vim/autoload/
	mv /tmp/work/vim-moonfly-colors/colors/moonfly.vim ~/.vim/colors/
	rm -Rf /tmp/work/vim-moonfly-colors
	[[ -z $(cat ~/.vimrc | grep '^colorscheme .*$') ]] && echo 'colorscheme moonfly' >> ~/.vimrc || sed -i -e 's/^colorscheme .*$/colorscheme moonfly/g' ~/.vimrc
}
Run() {
	InstallBuildTools
	Download
	Build
	ColorScheme
# 以下は実行しない。
#	. /home/pi/root/work/record/pc/reference/manual/raspbian/AutoInstall/src/install_vim_plugin.sh
#	VimPluginManager
}
Run

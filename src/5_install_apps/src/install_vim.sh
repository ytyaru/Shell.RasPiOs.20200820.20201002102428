#!/bin/bash
set -Ceu
#-----------------------------------------------------------------------------
# install_vim.sh
# クリップボードが使えるvimをインストールする。
#   `sudo apt install -y vim`でインストールしたvimはクリップボードが使えない。
#   `vim --version | grep 'clipboard'`で調べると`-clipboard`となっている。これが`+clipboard`である必要がある。
#   そのためにはvim-gtkをインストールする。
# 作成日時: 2020-10-03
# 確認時バージョン: VIM - Vi IMproved 8.1 (2018 May 18, compiled Jun 15 2019 16:41:15)

# http://note.kurodigi.com/vim-selfbuild/
#-----------------------------------------------------------------------------
sudo apt remove vim
sudo apt-get install vim-gtk
# +clipboard : OK,  -clipboard : NG
vim --version | grep clipboard
# ~/.vimrc
# set clipboard=unnamedplus


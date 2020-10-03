#!/bin/bash
set -Ceu
#-----------------------------------------------------------------------------
# vimプラグインマネージャとプラグインのインストール＆設定。
# をしようと思ったが大変すぎるのでやめた。ここに別ファイル化して途中状態を保存しておく。完成したら呼び出して使ってもいい。
#-----------------------------------------------------------------------------
# Vimのプラグインを管理するツール（vim-plug, dein.vim, NeoBundle, Vundle, vim-pathogen）
# https://github.com/junegunn/vim-plug
# https://qiita.com/park-jh/items/226fdc6c6ea7a7598616
# https://kashewnuts.github.io/2018/08/22/jedivim_memo.html
VimPluginManager() {
	mkdir -p ~/.vim/autoload
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

	local text=$(cat << EOS
if has('vim_starting')
  set rtp+=~/.vim/plugged/vim-plug
  if !isdirectory(expand('~/.vim/plugged/vim-plug'))
    echo 'install vim-plug...'
    call system('mkdir -p ~/.vim/plugged/vim-plug')
    call system('git clone https://github.com/junegunn/vim-plug.git ~/.vim/plugged/vim-plug/autoload')
  end
endif

call plug#begin('~/.vim/plugged')
  Plug 'junegunn/vim-plug', {'dir': '~/.vim/plugged/vim-plug/autoload'}
  Plug 'davidhalter/jedi-vim', {'for': 'python'}
  Plug 'hynek/vim-python-pep8-indent', {'for': 'python'}
call plug#end()
EOS
)
	[[ -z $(echo "$text" | grep '^call plug#end()$') ]] && echo "$text" >> ~/.vimrc

	# pyenv, venvなどpython管理環境を整えてからのほうが良い（どんどん面倒になっていく）
	pip install python-language-server
}


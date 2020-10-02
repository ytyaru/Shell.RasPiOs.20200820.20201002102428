#!/bin/bash
set -Ceu
#-----------------------------------------------------------------------------
# googleimagesdownload.sh
# 作成日時: 2019-03-28
# 確認時バージョン: ?
# https://github.com/hardikvasa/google-images-download
#-----------------------------------------------------------------------------
Run(){
	pip install google_images_download
	. ~/root/sys/workflow/script/sh/definalble/env/env.sh
	ExportPath ~/.local/bin
	#export PATH="${PATH}:~/.local/bin"
}
Run

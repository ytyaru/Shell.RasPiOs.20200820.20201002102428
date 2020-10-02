#!/bin/bash
set -Ceu
#-----------------------------------------------------------------------------
# アプリのインストールを自動化する（ファイルで指定する）
# 作成日時: 2019-03-16 09:36:27
#-----------------------------------------------------------------------------
TIMESTAMP="$(date "+%Y%m%d%H%M%S%N")"
InstallAppTsv() { echo "${HOME}/root/work/record/pc/reference/manual/raspbian/AutoInstall/apps.tsv"; }
LogUpdate() { echo "${HOME}/root/work/record/pc/reference/manual/raspbian/AutoInstall/log/update.${TIMESTAMP}.log"; }
LogSummary() { echo "${HOME}/root/work/record/pc/reference/manual/raspbian/AutoInstall/log/summary.${TIMESTAMP}.log"; }
LogDetails() { echo "${HOME}/root/work/record/pc/reference/manual/raspbian/AutoInstall/log/details.${TIMESTAMP}.log"; }
Help() {
    local command_name=$(basename $0)
    cat << EOS
Usage:
  ${command_name} [option -b|-w]

Options:
  -b BlackList  指定したグループのアプリを対象外とする。
  -w WhiteList  指定したグループのアプリのみ対象とする。

Tsv:
  $(InstallAppTsv)
  書式は以下。
  * 読み飛ばす
    * 1行目(ヘッダ行)
    * 行頭が#の行
  * 1列目はグループ名
    * メタ文字
      * `.`: 階層の区切り
      * `*`: 任意の子
  * 2列目はアプリ名または実行可能なスクリプトファイル名
  例)
Group	Target
System.Japanese.Font	fonts-vlgothic
#System.Japanese.Font	fonts-ipafont
#System.Japanese.Font	fonts-ipaexfont
System.Japanese.IME	fcitx-mozc
Sdk.CSharp	/tmp/install_sdk_mono.sh
Ide.CSharp	monodevelop
  コマンド例)
AutoInstall.sh                              TSVファイルすべて実行する
AutoInstall.sh -w '[[ $Group == "Ide.CSharp" ]]'  グループが"Ide.CSharp"のターゲットのみ実行する
AutoInstall.sh -w '[[ $Group == "Sdk.CSharp" || $Group == "Ide.CSharp" ]]'  グループが"Sdk.CSharp"か"Ide.CSharp"のターゲットのみ実行する
AutoInstall.sh -w '[[ $Group =~ System\..+ ]]'  グループが正規表現"System\..+"に一致するターゲットのみ実行する
AutoInstall.sh -b '[[ $Group =~ System\..+ ]]'  グループが正規表現"System\..+"に一致するターゲット以外を実行する
EOS
}
Run() {
	SystemUpdate
	echo "$(grep -v -e '^\s*#' -e '^\s*$' "$(InstallAppTsv)")" | tail -n +2 | ( while read line; do
		local Group=$(echo -e "$line" | cut -f1)
		local Target=$(echo -e "$line" | cut -f2)
		# ${HOME}/a.shのような変数を展開する
		local Target=$(echo $(eval echo ${Target}))

		[[ -z $ARM_WHITELIST && -z $ARM_BLACKLIST ]] && { InstallOrShell "$Group" "$Target"; continue; }
		[[ "True" = $(WhiteList) ]] && { InstallOrShell "$Group" "$Target"; continue; }
		[[ "False" = $(BlackList) ]] && { InstallOrShell "$Group" "$Target"; continue; }

#		[[ -n $ARM_WHITELIST || -n $ARM_BLACKLIST ]] && {
#			[[ "False" = $(WhiteList) ]] && continue
#			[[ "True" = $(BlackList) ]] && continue
#		}
#		InstallOrShell "$Group" "$Target"
	done;)
}
WhiteList() {
	[[ -z "$ARM_WHITELIST" ]] && echo "False";
	local match=$(eval test "$ARM_WHITELIST"; echo $?;)
	[[ $match -eq 1 ]] && echo "False";
	echo "True";
}
BlackList() {
	[[ -z "$ARM_BLACKLIST" ]] && echo "False";
	local match=$(eval test "$ARM_BLACKLIST"; echo $?;)
	[[ $match -eq 1 ]] && echo "False";
	echo "True";
}
SystemUpdate() {
	# 実行と時間計測
	local log_update=$((time sudo apt update -y) 2>&1)
	local time_update=$(echo "$log_update" | tail -n 3 | grep -E '^real\s{1}.*$' | cut -f2)
	local log_upgrade=$((time sudo apt upgrade -y) 2>&1)
	local time_upgrade=$(echo "$log_upgrade" | tail -n 3 | grep -E '^real\s{1}.*$' | cut -f2)
	local log_dist_upgrade=$((time sudo apt dist-upgrade -y) 2>&1)
	local time_dist_upgrade=$(echo "$log_dist_upgrade" | tail -n 3 | grep -E '^real\s{1}.*$' | cut -f2)
	# ログ出力する
	mkdir -p "$(dirname $(LogUpdate))"
	echo -e "update\t${time_update}" >> $(LogUpdate)
	echo -e "upgrade\t${time_upgrade}" >> $(LogUpdate)
	echo -e "dist_upgrade\t${time_dist_upgrade}\n" >> $(LogUpdate)
	echo "sudo apt update -y" >> $(LogUpdate)
	echo "$log_update" >> $(LogUpdate)
	echo "sudo apt upgrade -y" >> $(LogUpdate)
	echo "$log_upgrade" >> $(LogUpdate)
	echo "sudo apt dist-upgrade -y" >> $(LogUpdate)
	echo "$log_dist_upgrade" >> $(LogUpdate)
}
# 処理を実行する。
# $1: Group（TSVの1列目。グループ名。任意の文字列。）
# $2: Target（TSVの2列目。アプリ名または実行可能なシェルスクリプトファイルパス）
# もし$1がファイルパスならシェルスクリプトとして実行する。
# もし$1がそれ以外なら`sudo ap install -y $1`とする。
InstallOrShell() {
	local Group="$1"
	local Target="$2"
	# 処理を実行する
	[[ -f "${Target}" ]] && local NowInstallLog=$((time "$Target") 2>&1) || local NowInstallLog=$((time sudo apt install -y "$Target") 2>&1)
	# かかった時間を取得する
	local NowInstallTime=$(echo "$NowInstallLog" | tail -n 3 | grep -E '^real\s{1}.*$' | cut -f2)
	local FileSize=$(GetFileSize "$NowInstallLog")
	local Version=$(GetVersion "$NowInstallLog")
	# ログ出力する
	mkdir -p "$(dirname $(LogSummary))"
	mkdir -p "$(dirname $(LogDetails))"
	echo -e "${Group}\t${Target}\t${NowInstallTime}\t${FileSize}\t${Version}" >> $(LogSummary)
	echo "$(CommandString ${Target})" >> $(LogDetails)
	echo "$NowInstallLog" >> $(LogDetails)
}
CommandString() { [[ -f "$1" ]] && echo "$1" || echo "sudo apt install -y $1"; }
# sudo apt install -y出力ログからファイルサイズを取得する
# $1: 対象アプリのインストールログ
# 出力例): "1,234 kB"
GetFileSize() {
	local regex='この操作後に追加で (.*) (.*) のディスク容量が消費されます。'
	local text=$(echo "$1" | grep "この操作後に追加で .* .* のディスク容量が消費されます。")
	[[ $text =~  $regex ]] && echo "${BASH_REMATCH[1]} ${BASH_REMATCH[2]}" || echo ""
}
# sudo apt install -y出力ログからバージョンを取得する
# $1: 対象アプリのインストールログ
# 出力例): "7.6.0.711-0xamarin5+raspbian9b1"
GetVersion() {
	local regex='(.*) はすでに最新バージョン \((.*)\) です。'
	local text=$(echo "$1" | grep ".* はすでに最新バージョン \(.*\) です。")
	[[ $text =~  $regex ]] && echo "${BASH_REMATCH[2]}" || echo ""
}
GetError() {
	local regex='E: パッケージ (.*) が見つかりません'
	local text=$(echo "$1" | grep "E: パッケージ .* が見つかりません")
	[[ $text =~  $regex ]] && echo "パッケージが見つかりません" || echo ""
}

ARM_WHITELIST=
ARM_BLACKLIST=
while getopts "b:w:" OPT; do
	case $OPT in
	    "b" ) local ARM_BLACKLIST=$OPTARG ;;
	    "w" ) local ARM_WHITELIST=$OPTARG ;;
		\?  ) Help; exit ;;
	esac
done
[[ -n $ARM_WHITELIST && -n $ARM_BLACKLIST ]] && { echo "WhiteListとBlackListの両方を指定することはできません。やり直してください。"; exit 1; }
Run

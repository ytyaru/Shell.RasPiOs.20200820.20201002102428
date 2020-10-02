#!/bin/bash
set -Ceu
#-----------------------------------------------------------------------------
# install_rxvt-unicode.sh
# rangerで画像表示できるターミナル。
# 作成日時: 2019-03-20 09:44:35
#-----------------------------------------------------------------------------
Download() {
	mkdir -p /tmp/work
	cd /tmp/work
	local filename="rxvt-unicode-9.22.tar.bz2"
	wget "http://dist.schmorp.de/rxvt-unicode/Attic/${filename}"
	tar xf ${filename}
	local dname=${filename%.*}
	local dname=${dname%.*}
	cd /tmp/work/${dname}
}
Build() {
	./configure --help
	# https://kakurasan.hatenadiary.jp/entry/20081125/p1
	sudo ./configure \
		--enable-256-color \
		--enable-unicode3 \
		--enable-combining \
		--enable-xft \
		--enable-font-styles \
		--enable-pixbuf \
		--enable-startup-notification \
		--enable-transparency \
		--enable-fading \
		--enable-rxvt-scroll \
		--enable-next-scroll \
		--enable-xterm-scroll \
		--enable-perl \
		--disable-8bitctrls \
		--enable-keepscrolling \
		--enable-selectionscrolling \
		--enable-mousewheel \
		--enable-slipwheeling \
		--enable-text-blink \
		--enable-pointer-blank \
		--disable-utmp \
		--disable-wtmp \
		--disable-lastlog \
		--with-codesets=jp,jp_ext \
		--with-term=rxvt-256color

#		--disable-perl \
#		--disable-xft \
#		--disable-utmp \
#		--disable-wtmp \
#		--disable-lastlog \

# 以下フラグは削除した。
#		--enable-everything \
#		--enable-assert \
#		--enable-warnings \
#		--enable-perl \ # urxvt: unable to initialize perl-interpreter, continuing without.
	sudo make
#	./urxvt --version
#	/tmp/work/rxvt-unicode-9.22/src/rxvt --version
	./src/rxvt --version & true
	./src/rxvt -bg 0 -fg 7 -fn "xft:VL ゴシック:pixelsize=24" +sb -tr & true
# xft: http://www.02.246.ne.jp/~torutk/cxx/x11/string.html
# XIM: https://qiita.com/ai56go/items/63abe54f2504ecc940cd
# immodule: https://tkng.org/unixuser/200405/part1.html
# https://wiki.archlinux.jp/index.php/Rxvt-unicode/%E3%83%92%E3%83%B3%E3%83%88%E3%81%A8%E3%83%86%E3%82%AF%E3%83%8B%E3%83%83%E3%82%AF
	sudo make install
	urxvt --version & true
	urxvt -bg 0 -fg 7 -fn "xft:VL ゴシック:pixelsize=24" +sb -tr & true

# $ fc-list
# http://malkalech.com/urxvt_terminal_emulator#i-7
#	./src/rxvt -bg 0 -fg 7 -fn "xft:monospace:pixelsize=20"
#	./src/rxvt -bg 0 -fg 7 -fn "xft:VL ゴシック:pixelsize=24" +sb -tr
#	/tmp/work/rxvt-unicode-9.22/src/rxvt -fg 7 -bg 0 -fn "xft:VL ゴシック:pixelsize=24"
#	/tmp/work/rxvt-unicode-9.22/src/rxvt -fg 7 -bg 0 -fn "xft:monospace:pixelsize=20"

# タブ機能が欲しい。これはperl拡張。だがビルドオプションでperlインタプリタ`--disable-perl`を`--enable-perl`にしてできたバイナリで`/tmp/work/rxvt-unicode-9.22/rxvt --version`実行すると以下エラーになる。(`sudo make install`せずに`make`したバイナリを実行したから？)
#Can't locate urxvt.pm in @INC (you may need to install the urxvt module) (@INC contains: /usr/local/lib/urxvt /etc/perl /#usr/local/lib/arm-linux-gnueabihf/perl/5.24.1 /usr/local/share/perl/5.24.1 /usr/lib/arm-linux-gnueabihf/perl5/5.24 /usr/#share/perl5 /usr/lib/arm-linux-gnueabihf/perl/5.24 /usr/share/perl/5.24 /usr/local/lib/site_perl) at -e line 1.
#BEGIN failed--compilation aborted at -e line 1.
#urxvt: unable to initialize perl-interpreter, continuing without.
#*** Error in `/tmp/work/rxvt-unicode-9.22/src/rxvt': corrupted double-linked list: 0x01e99e98 ***
#中止

# `sudo make install`したらアプリ名が`urxvt`になった。`urxvt --version`が正しく表示された。
# `+sb`でスクロールバー非表示。`-sr`で右側表示。`-tr`で背景透過。
# urxvt -bg 0 -fg 7 -fn "xft:VL ゴシック:pixelsize=24" +sb
}
# タブ機能の拡張（できなかった）
Tabbed() {
	# 方法1: インストール方法わからず。
	# https://wiki.archlinux.jp/index.php/Rxvt-unicode/%E3%83%92%E3%83%B3%E3%83%88%E3%81%A8%E3%83%86%E3%82%AF%E3%83%8B%E3%83%83%E3%82%AF#.E9.AB.98.E5.BA.A6.E3.81.AA.E3.82.BF.E3.83.96.E3.81.AE.E7.AE.A1.E7.90.86
	cd /tmp/work
#	local dname=urxvt-tabbedex
#	git clone https://aur.archlinux.org/${dname}.git
#	git clone https://aur.archlinux.org/urxvt-tabbedex.git
#	cd ./${dname}
#	./configure --help
#	local text=$(cat << EOS
#URxvt.perl-ext-common: default,matcher,tabbedex
#URxvt.tabbed.new-button: true
#URxvt.tabbed.autohide: true
#URxvt.tabbed.reopen-on-close: yes
#URxvt.keysym.Control-t: perl:tabbedex:new_tab
#URxvt.keysym.Control-Tab: perl:tabbedex:next_tab
#URxvt.keysym.Control-Shift-Tab: perl:tabbedex:prev_tab
#URxvt.keysym.Control-Shift-Left: perl:tabbedex:move_tab_left
#URxvt.keysym.Control-Shift-Right: perl:tabbedex:move_tab_right
#URxvt.keysym.Control-Shift-R: perl:tabbedex:rename_tab
#EOS
#)
#	[[ ! -f ~/.Xresource ]] && echo "$text" > ~/.Xresource

	# 方法2: 起動できず。
	# https://github.com/gryf/tabbed
#	git clone https://github.com/gryf/tabbed
#	cd tabbed
#	mkdir ~/.urxvt
#	cp -a ./tabbed ~/.urxvt

#	local text=$(cat << EOS
#URxvt.perl-ext-common: default
#URxvt.perl-ext: tabbed
#! Any scripts placed here will override global ones with the same name
#URxvt.perl-lib: /home/user/.urxvt/
#
#! Tabbed extension configuration
#URxvt.tabbed.tabbar-fg: 8
#URxvt.tabbed.tabbar-bg: 0
#URxvt.tabbed.tab-fg:    15
#URxvt.tabbed.tab-bg:    8
#URxvt.tabbed.new-button: false
#EOS
#)
#	[[ ! -f ~/.Xdefaults ]] && echo "$text" > ~/.Xdefaults
# やはり起動できない。
#$ urxvt -pe tabbed
#urxvt: "pe": unknown or malformed option.
#urxvt: "tabbed": malformed option.
}
XResource() {
	# http://malkalech.com/urxvt_terminal_emulator#i-9
	local text=$(cat << EOS
!! ~/.Xresources
!! http://malkalech.com/urxvt_terminal_emulator#i-9
!! $ xrdb -merge ~/.Xresources
!! rxvt-unicode (urxvt)
!!

URxvt.geometry:             96x32
URxvt.scrollBar:            false
URxvt.scrollBar_right:      true
URxvt.scrollBar_floating:   true
URxvt.scrollstyle:          plain
URxvt.cursorBlink:          true
URxvt.cursorUnderline:      true
URxvt.pointerBlank:         true
URxvt.visualBell:           true
URxvt.saveLines:            3000
URxvt.fading:               40

!! Font list and Spacing
!! URxvt.font:                 xft:Dejavu Sans Mono-9,\
!!                             xft:IPAGothic
URxvt.font:                 xft:VL ゴシック-18,\
                            xft:IPAGothic-18
URxvt.letterSpace:          0
!URxvt.lineSpace:           0

!! Color Scheme and Opacity - gruvbox-dark https://github.com/morhetz/gruvbox
URxvt.depth:                24
URxvt.color1:               #cc241d
URxvt.color2:               #98971a
URxvt.color3:               #d79921
URxvt.color4:               #458588
URxvt.color5:               #b16286
URxvt.color6:               #689d6a
URxvt.color7:               #a89984
URxvt.color8:               #928374
URxvt.color9:               #fb4934
URxvt.color10:              #b8bb26
URxvt.color11:              #fabd2f
URxvt.color12:              #83a598
URxvt.color13:              #d3869b
URxvt.color14:              #8ec07c
URxvt.color15:              #ebdbb2
URxvt.foreground:           #ebdbb2
URxvt.background:           #282828
URxvt.colorIT:              #8ec07c
URxvt.colorBD:              #d5c4a1
URxvt.colorUL:              #83a598
URxvt.scrollColor:          #504945
!URxvt.troughColor:          #3C3836
EOS
)
	xrdb -merge ~/.Xresources
}
Run() {
	Download
	Build
}
Run

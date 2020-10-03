# ビルド

```sh
make
sudo apt remove --purge vim
sudo dpkg -i vim_20201003-1_armhf.deb
sudo apt remove --purge
```

# 実行

```sh
vim
```
```sh
Error detected while processing /home/pi/.vimrc[61]../usr/local/share/vim/vim82/colors/murphy.vim:
line   15:
E341: Internal error: lalloc(0, )
E254: Cannot allocate color Orange
line   19:
E341: Internal error: lalloc(0, )
E254: Cannot allocate color Wheat
line   27:
E341: Internal error: lalloc(0, )
E254: Cannot allocate color Orchid
line   39:
E341: Internal error: lalloc(0, )
E254: Cannot allocate color Pink
Press ENTER or type command to continue
```

　色の名前を16進数値に修正すると解決した。

　例えば以下。`Orange`を`#FD7E00`に修正した。なお先頭の`"`はコメントアウト。

```
" hi Comment		term=bold	   ctermfg=LightRed   guifg=Orange
hi Comment		term=bold	   ctermfg=LightRed   guifg=#FD7E00
```


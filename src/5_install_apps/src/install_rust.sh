#!/bin/bash
set -Ceu
#-----------------------------------------------------------------------------
# Rust言語のSDKをインストールする。
# Created: 2020-10-03
#-----------------------------------------------------------------------------
Run() { curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh; }
Run
# cargo new hello
# cd hello
# cargo run

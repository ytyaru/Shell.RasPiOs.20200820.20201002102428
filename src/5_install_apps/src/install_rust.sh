#!/bin/bash
set -Ceu
#-----------------------------------------------------------------------------
# install_rust.sh
# Created: 2019-05-18
#-----------------------------------------------------------------------------
Run() { curl https://sh.rustup.rs -sSf | sh; }
Run
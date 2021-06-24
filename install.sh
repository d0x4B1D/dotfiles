#!/bin/bash
#
# This script should be run via curl:
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/d0x4B1D/dotfiles/master/install.sh)"
# or via wget:
#   bash -c "$(wget -qO- https://raw.githubusercontent.com/d0x4B1D/dotfiles/master/install.sh)"

pushd $(dirname $0) > /dev/null

git clone -c core.eol=lf -c core.autocrlf=false --depth 1 https://github.com/d0x4B1D/dotfiles.git $HOME/.dotfiles
git clone -c core.eol=lf -c core.autocrlf=false --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.dotfiles/zsh/plugins/zsh-syntax-highlighting
cp $HOME/.dotfiles/config/zshrc $HOME/.zshrc

popd > /dev/null

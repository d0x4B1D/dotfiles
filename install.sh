#!/bin/bash
#
# This script should be run via curl:
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/d0x4B1D/dotfiles/master/install.sh)"
# or via wget:
#   bash -c "$(wget -qO- https://raw.githubusercontent.com/d0x4B1D/dotfiles/master/install.sh)"

pushd $(dirname $0) > /dev/null

if [ -d "$HOME/.dotfiles" ]; then
    read -p "~/.dotfiles already exists, override it? [y/N] " -n 1 -r yn
    echo
    case $yn in
        [Yy]* ) rm -rf $HOME/.dotfiles;;
        * ) exit;;
    esac
fi

git_flags="-c core.eol=lf -c core.autocrlf=false --depth 1" 

# clone dotfile repo
if [ -z "$1" ]; then
    git clone $git_flags https://github.com/d0x4B1D/dotfiles.git $HOME/.dotfiles
else
    echo "Cloning from branch $1"
    git clone $git_flags -b $1 https://github.com/d0x4B1D/dotfiles.git $HOME/.dotfiles
fi

# clone 3rdParty repos
git clone $git_flags https://github.com/romkatv/powerlevel10k.git $HOME/.dotfiles/zsh/themes/powerlevel10k
git clone $git_flags https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.dotfiles/zsh/plugins/zsh-syntax-highlighting
git clone $git_flags https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.dotfiles/zsh/plugins/zsh-autosuggestions

# install configs
ln -s $HOME/.dotfiles/config/zshrc $HOME/.zshrc
ln -s $HOME/.dotfiles/zsh/themes/p10k.zsh $HOME/.p10k.zsh

popd > /dev/null

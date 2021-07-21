#!/bin/bash
#
# This script should be run via curl:
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/d0x4B1D/dotfiles/master/install.sh)"
# or via wget:
#   bash -c "$(wget -qO- https://raw.githubusercontent.com/d0x4B1D/dotfiles/master/install.sh)"

pushd $(dirname $0) > /dev/null

#####################
# settings 
#

dotfile_branch=master
build_neovim=false
git_flags="-c core.eol=lf -c core.autocrlf=false --depth 1" 

#####################
# arg parser 
#
i=1
j=$#
while [ $i -le $j ]; do
    if [ "$1" == "--include-neovim" ]; then
        build_neovim=true 
    else 
        dotfile_branch=$1
    fi
    i=$((i + 1))
    shift 1
done

#####################
# other stuff 
#
if [ -d "$HOME/.dotfiles" ]; then
    read -p "~/.dotfiles already exists, override it? [y/N] " -n 1 -r yn
    echo
    case $yn in
        [Yy]* ) rm -rf $HOME/.dotfiles;;
        * ) exit;;
    esac
fi

#####################
# clone dotfile repo
#
echo "Cloning from branch $dotfile_branch"
git clone $git_flags -b $dotfile_branch https://github.com/d0x4B1D/dotfiles.git $HOME/.dotfiles

#####################
# clone 3rdParty repos
#
if [ "$build_neovim" == "true" ]; then
    git clone $git_flags https://github.com/neovim/neovim $HOME/.dotfiles/tmp/neovim
fi

git clone $git_flags https://github.com/romkatv/powerlevel10k.git $HOME/.dotfiles/zsh/themes/powerlevel10k
git clone $git_flags https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.dotfiles/zsh/plugins/zsh-syntax-highlighting
git clone $git_flags https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.dotfiles/zsh/plugins/zsh-autosuggestions

#####################
# install configs
#
cp $HOME/.dotfiles/config/zshrc $HOME/.zshrc
mkdir -p $HOME/.config/nvim/ && cp $HOME/.dotfiles/config/nvimrc $HOME/.config/nvim/init.vim
cp $HOME/.dotfiles/zsh/themes/p10k.zsh $HOME/.p10k.zsh

#####################
# build and install neovim
#
if [ "$build_neovim" == "true" ]; then
    pushd $HOME/.dotfiles/tmp/neovim > /dev/null
    make -j4
    sudo make install
    popd > /dev/null
fi

#####################
# install vim-plug 
#
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'


popd > /dev/null

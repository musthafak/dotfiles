#!/bin/bash

set -e

sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y
sudo apt install -y stow htop zsh tmux wget curl git zip

# LSD - A better ls
wget https://github.com/Peltoche/lsd/releases/download/0.23.1/lsd_0.23.1_amd64.deb \
    -O /tmp/lsd_0.23.1_amd64.deb
sudo dpkg -i /tmp/lsd_0.23.1_amd64.deb && rm /tmp/lsd_0.23.1_amd64.deb

LOCAL_BIN_DIR="$HOME/.local/bin"
[[ ! -d $LOCAL_BIN_DIR ]] && mkdir -p $LOCAL_BIN_DIR

# Install tmux
wget https://github.com/nelsonenzo/tmux-appimage/releases/download/3.2a/tmux.appimage \
    -O $LOCAL_BIN_DIR/tmux
chmod a+x $LOCAL_BIN_DIR/tmux

# Install neovim
wget https://github.com/neovim/neovim/releases/download/v0.8.3/nvim.appimage \
    -O $LOCAL_BIN_DIR/nvim
chmod a+x $LOCAL_BIN_DIR/nvim
sudo apt install -y python3-neovim python3-pip python3-venv build-essential \
    ripgrep fd-find fuse entr jq
sudo apt remove -y xclip
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - &&\
sudo apt-get install -y nodejs
pushd $LOCAL_BIN_DIR
wget https://github.com/equalsraf/win32yank/releases/download/v0.1.1/win32yank-x64.zip
unzip win32yank-x64.zip && chmod a+x win32yank.exe && rm LICENSE README.md win32yank-x64.zip
popd

# Change default shell to zsh
sudo usermod -s /usr/bin/zsh $USER

# Install python
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update && sudo apt install -y python3.9-full python3.10-full

# Create a workspace directory
USER_WORKSPACE=$HOME/workspace/$USER
[[ ! -d $USER_WORKSPACE ]] && mkdir -p $USER_WORKSPACE

# Download and setup config files
DOTFILES_PATH=$USER_WORKSPACE/dotfiles
if [[ ! -d $DOTFILES_PATH ]]; then
    git clone git@github.com:musthafak/dotfiles.git $DOTFILES_PATH
else
    git -C $DOTFILES_PATH pull --ff
fi
pushd $DOTFILES_PATH
[[ ! -d $HOME/.config ]] && mkdir -p $HOME/.config
stow -t $HOME/ .
popd


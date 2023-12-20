#!/bin/bash

set -e

# Update system
sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y

# Install packages
sudo apt install -y ubuntu-restricted-extras curl git htop stow zsh lsd alacritty docker.io tmux

# Enable flatpak and install apps
sudo apt install -y flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y com.mattjakeman.ExtensionManager de.haeckerfelix.Fragments org.gnome.meld \
    com.github.rafostar.Clapper de.haeckerfelix.Shortwave io.bassi.Amberol

# Install GPU packages
sudo apt install -y intel-media-va-driver-non-free vainfo intel-gpu-tools

LOCAL_BIN_DIR="$HOME/.local/bin"
[[ ! -d $LOCAL_BIN_DIR ]] && mkdir -p $LOCAL_BIN_DIR

# Install NeoVim
wget https://github.com/neovim/neovim/releases/download/v0.9.4/nvim.appimage \
    -O $LOCAL_BIN_DIR/nvim
chmod a+x $LOCAL_BIN_DIR/nvim
sudo apt install -y python3-neovim python3-pip python3-venv build-essential \
    ripgrep fd-find libfuse2 entr jq nodejs npm


# Change default shell to zsh
sudo usermod -s /usr/bin/zsh $USER

# Create a workspace directory
USER_WORKSPACE=$HOME/workspace/$USER
[[ ! -d $USER_WORKSPACE ]] && mkdir -p $USER_WORKSPACE

# Download and setup config files
DOTFILES_PATH=$USER_WORKSPACE/dotfiles
if [[ ! -d $DOTFILES_PATH ]]; then
    git clone https://github.com/musthafak/dotfiles.git $DOTFILES_PATH
else
    git -C $DOTFILES_PATH pull --ff
fi
pushd $DOTFILES_PATH
[[ ! -d $HOME/.config ]] && mkdir -p $HOME/.config
stow -t $HOME/ .
popd

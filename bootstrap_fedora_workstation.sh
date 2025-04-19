#!/bin/bash

set -e

# Only suppots fedora
[[ ! -f /etc/fedora-release ]] && echo "ERROR: Only supports fedora!" && exit 1

# Enable RPM Fusion and VS Code repo.
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1

# Install multi-media packages
sudo dnf update --refresh
sudo dnf update -y @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin

# Others
sudo dnf install -y stow htop zsh lsd alacritty

# VA-API
sudo dnf install -y libva libva-utils intel-media-driver intel-gpu-tools gstreamer1-vaapi

# Neovim
sudo dnf install -y neovim python3-neovim python3-pip gcc-c++ nodejs ripgrep fd-find

# Change default shell to zsh
sudo usermod -s /usr/bin/zsh $USER

# Install flatpak apps from flathub
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install com.mattjakeman.ExtensionManager de.haeckerfelix.Fragments \
    com.github.rafostar.Clapper de.haeckerfelix.Shortwave io.bassi.Amberol

# Create a workspace directory
USER_WORKSPACE=$HOME/workspace/$USER
if [[ ! -d $USER_WORKSPACE ]]; then
    mkdir -p $USER_WORKSPACE
fi

# Download and setup config files
DOTFILES_PATH=$USER_WORKSPACE/dotfiles
if [[ ! -d $DOTFILES_PATH ]]; then
    git clone https://github.com/musthafak/dotfiles.git $DOTFILES_PATH
else
    git -C $DOTFILES_PATH pull --ff
fi
pushd $DOTFILES_PATH
stow -t $HOME/ .
popd

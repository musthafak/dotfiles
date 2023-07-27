#!/bin/bash

set -e

# Update and install packages
echo "deb http://deb.debian.org/debian bookworm-backports main contrib non-free" | \
    sudo tee /etc/apt/sources.list.d/backports.list
sudo apt update && sudo apt -t bookworm-backports upgrade -y
sudo apt install -y stow htop zsh tmux wget curl git zip -t bookworm-backports
wget https://github.com/Peltoche/lsd/releases/download/0.23.1/lsd_0.23.1_amd64.deb \
    -O /tmp/lsd_0.23.1_amd64.deb
sudo dpkg -i /tmp/lsd_0.23.1_amd64.deb && rm /tmp/lsd_0.23.1_amd64.deb

LOCAL_BIN_DIR="$HOME/.local/bin"
[[ ! -d $LOCAL_BIN_DIR ]] && mkdir $LOCAL_BIN_DIR

# Install neovim
wget https://github.com/neovim/neovim/releases/download/v0.8.3/nvim.appimage \
    -O $LOCAL_BIN_DIR/nvim
chmod a+x $LOCAL_BIN_DIR/nvim
sudo apt install -y python3-neovim python3-pip python3-venv build-essential nodejs npm \
    ripgrep fd-find fuse entr -t bookworm-backports
sudo apt remove -y xclip
pushd $LOCAL_BIN_DIR
wget https://github.com/equalsraf/win32yank/releases/download/v0.1.1/win32yank-x64.zip
unzip win32yank-x64.zip && chmod a+x win32yank.exe && rm LICENSE README.md win32yank-x64.zip
popd

# Change default shell to zsh
sudo usermod -s /usr/bin/zsh $USER

# Build below mentioned python packages for development
PYTHON_VERSIONS="3.11.4 3.9.17"
sudo apt install -y build-essential libncurses5-dev zlib1g-dev libnss3-dev libgdbm-dev \
    libssl-dev libsqlite3-dev libffi-dev libreadline-dev libbz2-dev tk-dev wget \
    -t bookworm-backports
LOCAL_BUILDS_DIR=$LOCAL_BIN_DIR/builds
[[ ! -d $LOCAL_BUILDS_DIR ]] && mkdir -p $LOCAL_BUILDS_DIR
pushd $LOCAL_BUILDS_DIR
for PYTHON_VERSION in $PYTHON_VERSIONS; do
    wget https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz
    [[ -d Python-$PYTHON_VERSION ]] && rm -rf Python-$PYTHON_VERSION
    tar -xf Python-$PYTHON_VERSION.tgz && rm Python-$PYTHON_VERSION.tgz
    pushd Python-$PYTHON_VERSION
    ./configure --enable-optimizations && make -j 4
    sudo make altinstall
    popd
done
popd

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

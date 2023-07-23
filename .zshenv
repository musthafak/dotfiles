export EDITOR="nvim"
export VISUAL="nvim"
export MANPAGER='nvim +Man!'

export ZDOTDIR="$HOME/.config/zsh"

typeset -U path PATH
path=($HOME/.local/bin $path)
path=($HOME/.cargo/bin $path)
path=($HOME/.cache/npm/bin $path)
export PATH

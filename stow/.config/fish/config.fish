# Environment
set -gx EDITOR nvim

# PATH

## Doom Emacs binaries
set -Ua fish_user_paths ~/.config/emacs/bin/

# Miscellaneous

## Disable fish greeting
set fish_greeting

## Initialize Starship
starship init fish | source

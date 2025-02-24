# Environment
set -gx EDITOR emacsclient -c
set -gx VISUAL emacsclient -c

# PATH

## Doom Emacs binaries
set -Ua fish_user_paths ~/.config/emacs/bin/

# Miscellaneous

## Disable fish greeting
set fish_greeting

## Initialize Starship
starship init fish | source

# Environment
set -gx EDITOR emacsclient -nw
set -gx VISUAL emacsclient -nw

# PATH

## Doom Emacs binaries
set -Ua fish_user_paths ~/.config/emacs/bin/

# Miscellaneous

## Disable fish greeting
set fish_greeting

## Initialize Starship
starship init fish | source

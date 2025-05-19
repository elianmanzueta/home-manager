# Git
abbr --add gst git status
abbr --add gcsm git commit --signoff --message
abbr --add gp git push
abbr --add ga git add

# Cargo
abbr --add cr cargo run

# Emacs
abbr --add em "emacsclient -c &"
abbr --add killemacs "killall emacs"
abbr --add emacs emacs --daemon

# Ls
abbr --add ls eza -lhaF --color=auto --icons=always
abbr --add l eza -lhaF --color=auto --icons=always
abbr --add lt eza --tree

# Config
abbr --add fishconfig nvim ~/.config/fish/
abbr --add starshipconfig nvim ~/.config/starship.toml
abbr --add nvimconfig nvim ~/.config/nvim

# System
abbr --add update sudo aptitude update
abbr --add upgrade sudo aptitude upgrade

# Nix
abbr --add rebuild darwin-rebuild switch --flake /Users/elian/.config/nix

# Zoxide
abbr --add cd z

# Git
if type -q git
    abbr --add gst git status
    abbr --add gcsm git commit --signoff --message
    abbr --add gp git push
    abbr --add ga git add
    abbr --add gc git clone
end

# Brew
if type -q brew
    abbr --add bu brew upgrade
end

# Cargo
if type -q cargo
    abbr --add cr cargo run
end

# Emacs
if type -q emacsclient
    abbr --add em "emacsclient -c &"
    abbr --add killemacs "emacsclient -e \"(kill-emacs)"\"
    abbr --add emacs emacs --daemon

    abbr --add ff vterm_cmd find-file .

    abbr --add orgidp git commit --signoff --message ".orgids"
end

# Ls
if type -q eza
    abbr --add ls eza -lhaF --color=auto --icons=always
    abbr --add l eza -lhaF --color=auto --icons=always
    abbr --add lt eza --tree
else
    abbr --add ls ls -lhaF --color=auto
    abbr --add l ls -lhaF --color=auto
    abbr --add lt ls --tree
end

# Zoxide
abbr --add cd z

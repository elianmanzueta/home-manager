# @fish-lsp-disable 7001
# Git
if type -q git
    abbr --add gst git status
    abbr --add gcsm git commit --signoff --message
    abbr --add gp git push
    abbr --add ga git add
    abbr --add gc git clone
end

# Cargo
if type -q cargo
    abbr --add cr cargo run
end

# Emacs
if type -q emacsclient
    abbr --add em "emacsclient -c"
    abbr --add et "emacsclient -nw"

    if type -q systemctl
        abbr --add killemacs "systemctl --user stop emacs"
        abbr --add startemacs "systemctl --user start emacs"
    else
        abbr --add killemacs "emacsclient -e \"(kill-emacs)"\"
        abbr --add startemacs "emacs --daemon"
    end

    abbr --add ff vterm_cmd find-file .

    abbr --add orgidp git commit --signoff --message ".orgids"
end

function upgrade --description "Performs updates on a system."
    echo "===============UPDATING PACKAGES==============="
    if type -q pacman
        if type -q paru
            paru -Syu
        else
            pacman -Syu --noconfirm
        end

    else if type -q dnf
        dnf upgrade
    else if type -q apt
        apt update
        apt upgrade -y
    else if type -q brew
        brew upgrade
    end

    if type -q flatpak
        echo "===============UPDATING FLATPAKS==============="
        flatpak upgrade -y
    end

    if type -q doom
        echo "===============UPDATING DOOM EMACS==============="
        doom upgrade
    end
end

# Ls
abbr --add ls eza -lhaF --color=auto --icons=always
abbr --add l eza -lhaF --color=auto --icons=always
abbr --add lt eza --tree

# Zoxide
abbr --add cd z

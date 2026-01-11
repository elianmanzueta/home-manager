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
    if type -q wslinfo
        abbr --add em "emacsclient -c"
        abbr --add et "emacsclient -nw"

    else
        abbr --add em "emacsclient -c &"
        abbr --add et "emacsclient -nw &"

    end
    abbr --add ed emacs --daemon
    abbr --add killemacs "emacsclient -e \"(kill-emacs)"\"

    abbr --add ff vterm_cmd find-file .

    abbr --add orgidp git commit --signoff --message ".orgids"
end

function upgrade --description "Performs updates on a system."
    switch (uname)
        case Linux
            set distro (cat /etc/os-release | awk -F "=" ' /ID_LIKE/ { print $2 }' | tr -d '"')
            echo "===============UPDATING PACKAGES==============="
            if test $distro = arch
                if type -q paru
                    paru -Syu --skipreview
                else
                    pacman -Syu --noconfirm
                end
            end

            if type -q flatpak
                echo "===============UPDATING FLATPAKS==============="
                flatpak upgrade -y
            end

            if type -q doom
                echo "===============UPDATING DOOM EMACS==============="
                doom upgrade
            end
        case Darwin
            echo "===============UPDATING PACKAGES==============="
            brew upgrade
    end
end

# Ls
abbr --add ls eza -lhaF --color=auto --icons=always
abbr --add l eza -lhaF --color=auto --icons=always
abbr --add lt eza --tree

# Zoxide
abbr --add cd z

switch (uname)
    case Darwin
        # macOS-specific commands
        fish_add_path /Users/elian/.config/emacs/bin
	fish_add_path /etc/profiles/per-user/elian/bin

    case Linux
        # Linux-specific commands
        fish_add_path /home/elian/.local/bin
        fish_add_path /home/elian/.config/emacs/bin/
        fish_add_path /home/elian/.cargo/bin/
end

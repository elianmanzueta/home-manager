#!/usr/bin/env fish

switch (uname)
    case Darwin
        # macOS-specific commands
        fish_add_path /Users/elian/.config/emacs/bin
    case Linux
        # Linux-specific commands
        fish_add_path /home/elian/.local/bin
        fish_add_path /home/elian/.config/emacs/bin/
end

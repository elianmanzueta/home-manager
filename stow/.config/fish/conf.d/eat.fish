#!/usr/bin/env fish

if status is-interactive; and test -n $EAT_SHELL_INTEGRATION_DIR
    source $EAT_SHELL_INTEGRATION_DIR/fish
end

default:
    @just rebuild

rebuild:
    @if [ "$(uname)" = "Darwin" ]; then \
        darwin-rebuild switch --flake .#mbp; \
    elif [ "$(uname -a | grep -i WSL)" ]; then \
        home-manager switch --flake .#wsl; \
    elif [ "$(uname)" = "Linux" ]; then \
        home-manager switch --flake .#linux; \
    else \
        exit 1; \
    fi

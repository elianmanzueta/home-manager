default:
    @just rebuild

rebuild:
    @if [ "$(uname)" = "Darwin" ]; then \
        darwin-rebuild switch -b backup --flake .#mbp; \
    elif [ "$(uname -a | grep -i WSL)" ]; then \
        home-manager switch -b backup --flake .#wsl; \
    elif [ "$(uname)" = "Linux" ]; then \
        home-manager switch -b backup --flake .#linux; \
    else \
        exit 1; \
    fi

stow:
    @stow -t ~ stow/

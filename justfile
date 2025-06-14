default:
    @just rebuild

rebuild:
    @if [ "$(uname)" = "Darwin" ]; then \
        sudo darwin-rebuild switch --flake .#elians-MBP; \
    elif [ "$(uname -a | grep -i WSL)" ]; then \
        home-manager switch -b backup --flake .#wsl; \
    elif [ "$(uname -a | grep -i nixos)" ]; then \
        sudo nixos-rebuild switch --flake .#elian-nixos; \
    elif [ "$(uname)" = "Linux" ]; then \
        home-manager switch -b backup --flake .#linux; \
    else \
        exit 1; \
    fi

stow:
    @stow -t ~ stow/ --adopt

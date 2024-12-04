default:
    @just rebuild

rebuild:
    @if [ "$(uname)" = "Darwin" ]; then \
        echo "Running darwin-rebuild on macOS..."; \
        darwin-rebuild switch --flake .#mbp; \
    elif [ "$(uname -a | grep -i WSL)" ]; then \
        home-manager switch .#wsl; \
    elif [ "$(uname)" = "Linux" ]; then \
        home-manager switch --flake .#linux; \
    else \
        exit 1; \
    fi

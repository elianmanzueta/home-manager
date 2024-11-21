# home.nix

{ config, pkgs, ... }:

{
  home.username = "elian";
  home.homeDirectory = "/home/elian";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = [
    # Terminal
    pkgs.neovim
    pkgs.fzf
    pkgs.ripgrep
    pkgs.wget
    pkgs.zoxide
    pkgs.eza
    pkgs.fd
    pkgs.uv
    pkgs.emacs
    pkgs.progress
    pkgs.gcc
    pkgs.nodejs

    # Go
    pkgs.go
    pkgs.gopls

    # Python
    pkgs.python3
    pkgs.pyright

    # Emacs stuff
    pkgs.sqlite
    pkgs.ispell
    
    # Font
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  home.file = {
    ".config/starship.toml" = {
      source = ../../config/starship/starship.toml;
    };

    ".config/paru/" = {
      source = ../../config/paru;
      recursive = true;
    };

    ".config/fish" = {
      source = ../../config/fish;
      recursive = true;
    };

    ".config/doom" = {
      source = ../../config/doom;
      recursive = true;
    };

    ".wezterm.lua" = {
      source = ../../config/wezterm/.wezterm.lua;
    };

  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

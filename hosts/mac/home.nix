# home.nix

{ config, pkgs, ... }:

{
  home.username = "elian";
  home.homeDirectory = "/Users/elian";
  home.stateVersion = "23.05"; # Please read the comment before changing.

  home.packages = [
    pkgs.neovim
    pkgs.fzf
    pkgs.ripgrep
    pkgs.lazygit
    pkgs.wget
    pkgs.zoxide
    pkgs.nodejs
    pkgs.python3
    pkgs.eza
    pkgs.rustup
    pkgs.fd
    pkgs.progress
    pkgs.basedpyright
    pkgs.nil
    pkgs.go
    pkgs.gopls
    pkgs.uv
    pkgs.pyenv
    pkgs.sqlite
    pkgs.ispell
    pkgs.pandoc

    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  home.file = {

    ".config/fish" = {
      source = ../../config/fish;
      recursive = true;
    };

    ".config/starship.toml" = {
      source = ../../config/starship/starship.toml;
    };

    ".config/paru/" = {
      source = ../../config/paru;
      recursive = true;
    };

    ".wezterm.lua" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nix/.config/.wezterm.lua";
    };

    ".config/doom" = {
      source = ../../config/doom;
      recursive = true;
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;

    git = {
      enable = true;
      userName = "Elian Manzueta";
      userEmail = "elianmanzueta@protonmail.com";
      ignores = [
        ".DS_Store"
      ];
      extraConfig = {
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
      };
    };

    fish = {
      enable = true;
    };

    starship = {
      enable = true;
    };
  };

}

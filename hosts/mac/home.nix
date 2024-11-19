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
    pkgs.pyright

    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  home.file = {

    ".config/starship.toml" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nix/.config/starship.toml";
    };

    ".config/paru/" = {
      source = ../../config/paru;
      recursive = true;
    };

    ".wezterm.lua" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nix/.config/.wezterm.lua";
    };

  };

  xdg.configFile = {
    "fish" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nix/.config/fish";
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

    starship = {
      enable = true;
    };
  };

}

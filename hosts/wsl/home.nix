# home.nix

{ config, pkgs, ... }:

{
  home.username = "elian";
  home.homeDirectory = "/home/elian";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = [
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

    ".wezterm.lua" = {
      source = ../../config/wezterm/.wezterm.lua;
    };

    ".doom.d/" = {
      source = ../../config/doom;
      recursive = true;
    };

  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

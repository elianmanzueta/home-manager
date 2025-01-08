# home.nix

{ config, pkgs, ... }:

{
  home.username = "elian";
  home.homeDirectory = "/home/elian";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = [
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  fonts.fontconfig.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

# home.nix

{ config, pkgs, ... }:

{
  home.username = "elian";
  home.homeDirectory = "/Users/elian";
  home.stateVersion = "24.05"; # Please read the comment before changing.
  programs.home-manager.enable = true;

  home.packages = [
  ];

  home.sessionVariables = { EDITOR = "nvim"; };
}

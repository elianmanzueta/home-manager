# emacs.nix
#
{ config, lib, pkgs, ... }:

{
  home.username = "elian";
  home.homeDirectory = "/home/elian";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    fzf
    ripgrep
    fd
    gcc
    nodejs
    ispell
    sqlite
    emacs
  ];
}

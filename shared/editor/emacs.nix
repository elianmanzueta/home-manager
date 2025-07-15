# emacs.nix
{ config, lib, pkgs, ... }:

{
  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    nodejs
    enchant
    hunspell
    hunspellDicts.en_US
    sqlite
    nodePackages.prettier
    cmake
    vips
    libtool
    glibtool
    gnumake
    gcc
  ];
}

# emacs.nix
{ config, lib, pkgs, ... }:

{
  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    fzf
    ripgrep
    fd
    nodejs
    enchant
    hunspell
    hunspellDicts.en_US
    (aspellWithDicts (dicts: with dicts; [ en en-computers en-science es ]))
    sqlite
    nodePackages.prettier
    cmake
    libtool
    glibtool
    gnumake
    gcc
  ];
}

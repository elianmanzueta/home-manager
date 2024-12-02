# neovim.nix

{ config, lib, pkgs, ... }:

{
  home.username = "elian";
  home.homeDirectory = "/home/elian";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    neovim
    fzf
    ripgrep
    fd
    nodejs
    gcc
    lazygit
  ];
}

# home.nix

{ config, pkgs, ... }:

{

  imports = [
    ../../shared/terminal/default.nix
    ../../shared/editor/emacs.nix
    ../../shared/editor/neovim.nix
    ../../shared/code/nix.nix
    ../../shared/fonts/fonts.nix
    ../../shared/code/go.nix
    ../../shared/code/python.nix
    ../../shared/code/data.nix
  ];

  home.packages = with pkgs; [ neovim stow rustup emacs-pgtk cmake nixfmt ];

  programs.bat.enable = true;
  programs.zoxide.enable = true;
  programs.fzf.enable = true;

  programs.git = {
    enable = true;
    userName = "Elian Manzueta";
    userEmail = "elianmanzueta@protonmail.com";
  };

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "24.05";
  home.username = "elian";
  home.homeDirectory = "/Users/elian";
  programs.home-manager.enable = true;

}

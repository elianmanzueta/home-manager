{ config, pkgs, lib, ... }:

{
  home.username = "elian";
  home.homeDirectory = "/home/elian";

  imports = [
    ../../shared/terminal/default.nix
    ../../shared/editor/emacs.nix
    ../../shared/editor/neovim.nix
    ../../shared/code/nix.nix
    ../../shared/fonts/fonts.nix
    ../../shared/code/go.nix
    ../../shared/code/python.nix
    ../../shared/code/data.nix
    ../../shared/applications/default.nix
  ];

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    openfortivpn
    openfortivpn-webview-qt
    waybar
    swaybg
    waypaper
    fuzzel
    pavucontrol
    cargo
    rustc
    hugo
    prismlauncher
    graphviz
    teams-for-linux
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Elian Manzueta";
    userEmail = "elianmanzueta@protonmail.com";
  };

  programs.gh = { enable = true; };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";
}

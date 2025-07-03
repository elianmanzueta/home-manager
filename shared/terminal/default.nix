{ config, lib, pkgs, ... }:

{
  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    fzf
    ripgrep
    fd
    progress
    eza
    zoxide
    wget
    just
    gh
    stow
    nix-search-cli
    vips
  ];

  home.sessionVariables = { EDITOR = "nvim"; };

  programs = { starship = { enable = true; }; };
}

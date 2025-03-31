{ config, pkgs, ... }:

{
  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    nil
    nixpkgs-fmt
  ];
}

{ config, pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  programs.git = {
    enable = true;
    userName = "Elian Manzueta";
    userEmail = "elianmanzueta@protonmail.com";
  };

}

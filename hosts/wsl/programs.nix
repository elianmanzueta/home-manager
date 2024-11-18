# programs.nix

{ config, pkgs, ... }:

{
  programs = {
    git = {
      enable = true;
      userName = "Elian Manzueta";
      userEmail = "elianmanzueta@protonmail.com";
    };

    fish = {
      enable = true;
    };

    starship = {
      enable = true;
    };
  };
}


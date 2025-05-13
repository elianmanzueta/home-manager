{ config, lib, pkgs, ... }:

{
  home.packages = [
      pkgs.nerd-fonts.jetbrains-mono
      pkgs.nerd-fonts.iosevka
      pkgs.nerd-fonts.iosevka-term
  ];

  fonts.fontconfig.enable = true;
}

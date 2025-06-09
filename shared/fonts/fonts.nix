{ config, lib, pkgs, ... }:

{
  home.packages = [
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.iosevka
    pkgs.nerd-fonts.iosevka-term
    pkgs.nerd-fonts.zed-mono
    pkgs.nerd-fonts.symbols-only
  ];

  fonts.fontconfig.enable = true;
}

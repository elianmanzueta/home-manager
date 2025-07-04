{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    vivaldi
    networkmanager-openvpn
    proton-pass
    protonmail-desktop
    protonmail-bridge
    gparted
    onlyoffice-desktopeditors
    remmina
    vesktop
    spotify
    stremio
    unzip
    vlc
    kitty
  ];

}

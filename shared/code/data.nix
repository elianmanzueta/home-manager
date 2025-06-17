{ config, pkgs, ... }:

{
  home.stateVersion = "24.05";

  home.packages = with pkgs; [ yaml-language-server yamlfmt jsonfmt ];
}

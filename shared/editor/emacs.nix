# emacs.nix
{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    fzf
    ripgrep
    fd
    nodejs
    # enchant
    sqlite
    nodePackages.prettier
    wkhtmltopdf
  ];
}

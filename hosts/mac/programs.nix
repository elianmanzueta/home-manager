{ pkgs, ... }:
{
  users.users.elian = {
    name = "elian";
    home = "/Users/elian";
    shell = pkgs.fish;
  };

  environment = {
    systemPackages = with pkgs; [
      neovim
      fish
    ];

    shells = [
      pkgs.fish
      pkgs.bash
      pkgs.zsh
    ];

  };

  programs = {
    fish = {
      enable = true;
    };
  };

  system = {
    stateVersion = 4;
    defaults = {
      dock = {
        autohide = true;
        tilesize = 24;
        autohide-delay = 0.0;
        mineffect = "suck";
        magnification = true;
      };
    };
  };
}

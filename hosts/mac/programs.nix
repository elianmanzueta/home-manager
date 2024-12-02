 { pkgs, ... }:
{
  users.users.elian = {
    name = "elian";
    home = "/Users/elian";
    shell = pkgs.fish;
  };

  programs = {
    fish = {
      enable = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      neovim
    ];

    shells = [
      pkgs.fish
      pkgs.bash
      pkgs.zsh
    ];

  };


  homebrew = {
    enable = true;
    taps = [
    ];
    brews = ["fish"];
    casks = [];
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

      finder = {
        AppleShowAllExtensions = true;
        ShowPathbar = true;
      };
    };

  };
}

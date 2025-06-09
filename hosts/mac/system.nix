{ config, pkgs, ... }: {
  system = {
    stateVersion = 6;

    defaults = {
      dock = {
        autohide = true;
        autohide-time-modifier = 0.3;
        mineffect = "suck";
        magnification = true;
        largesize = 64;
        launchanim = true;
      };

      controlcenter = { BatteryShowPercentage = true; };
      finder = {
        AppleShowAllFiles = true;
        AppleShowAllExtensions = true;
        ShowPathbar = true;
        FXPreferredViewStyle = "Nlsv";
        FXEnableExtensionChangeWarning = false;
      };
    };

  };
}

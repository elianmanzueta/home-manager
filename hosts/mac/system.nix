{ config, pkgs, ... }: {
  networking.hostName = "elians-MBP";

  system = {
    stateVersion = 6;

    defaults = {
      dock = {
        autohide = false;
        autohide-time-modifier = 0.0;
        mineffect = "suck";
        magnification = true;
        largesize = 64;
        launchanim = true;

        persistent-apps = [
          "/System/Applications/Launchpad.app"
          "/Applications/Vivaldi.app"
          "/Applications/kitty.app"
          "/Applications/Stremio.app"
          "/Applications/Proton Mail.app"
          "/Applications/Proton Pass.app"
          "/System//Applications/System Settings.app"
        ];

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

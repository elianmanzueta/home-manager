{ config, pkgs, ... }: {
  system = {
    stateVersion = 4;
    activationScripts.postUserActivation.text = ''
      # activateSettings -u will reload the settings from the database and apply them to the current session,
      # so we do not need to logout and login again to make the changes take effect.
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

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

  security.pam.enableSudoTouchIdAuth = true;
}

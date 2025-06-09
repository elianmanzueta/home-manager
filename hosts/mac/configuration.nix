{ pkgs, ... }:

{
  # Home-manager
  users.users.elian = {
    name = "elian";
    home = "/Users/elian";
  };

  nix.settings = { experimental-features = [ "nix-command" "flakes" ]; };

  # Auto upgrade nix package and the daemon service.
  nix.enable = true;
  nix.package = pkgs.nix;
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = 6;
  system.primaryUser = "elian";

  homebrew = {
    enable = true;
    # onActivation.cleanup = "uninstall";

    taps = [ ];
    brews = [ "fish" ];
    casks = [
      "vivaldi"
      "stremio"
      "kitty"
      "zoom"
      "microsoft-teams"
      "proton-pass"
      "proton-mail"
    ];
  };

}

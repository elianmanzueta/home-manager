{ config, pkgs, ... }:
{
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;
  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";
  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;
}

{ config, pkgs, ... }:
{
  # Auto upgrade nix package and the daemon service.
  nix.package = pkgs.nix;
  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";
  # The platform the configuration will be used on.
  nixpkgs.config.allowUnfree = true;

  }

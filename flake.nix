{
  description = "Home Manager configuration of elian";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, ... }:
    let
      pkgsDarwin = nixpkgs.legacyPackages.aarch64-darwin;
      pkgsLinux = nixpkgs.legacyPackages.x86_64-linux;

    in {
      homeConfigurations = {
        "mac" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsDarwin;
          modules = [
            ./hosts/mac/home.nix
            ./shared/terminal/default.nix
            ./shared/editor/neovim.nix
            ./shared/editor/emacs.nix
            ./shared/code/nix.nix
            ./shared/code/python.nix

          ];
        };

        "wsl" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsLinux;
          modules = [
            ./hosts/wsl/home.nix
            ./shared/terminal/default.nix
            ./shared/editor/neovim.nix
            ./shared/editor/emacs.nix
            ./shared/code/nix.nix
            ./shared/code/python.nix
          ];

        };
        "linux" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsLinux;
          modules = [
            ./hosts/cachy/configuration.nix
            ./hosts/cachy/home.nix
            ./hosts/cachy/programs.nix
            ./shared/code/python.nix
            ./shared/code/go.nix
            ./shared/editor/emacs.nix
            ./shared/editor/neovim.nix
            ./shared/terminal/default.nix
          ];
        };
      };
    };
}

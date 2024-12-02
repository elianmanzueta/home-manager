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
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      darwinConfigurations = {
        "mbp" = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ./hosts/mac/configuration.nix
            ./hosts/mac/programs.nix
            ./shared/code/python.nix
            ./shared/code/go.nix
            ./shared/code/rust.nix
            ./shared/editor/emacs.nix
            ./shared/editor/neovim.nix

            home-manager.darwinModules.home-manager
            {
              home-manager.backupFileExtension = "hm-backup";
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.verbose = true;
              home-manager.users.elian = import ./hosts/mac/home.nix;
            }
          ];
        };
      };

      homeConfigurations = {
        "elian-wsl" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./hosts/wsl/home.nix
            ./shared/code/nix.nix
            ./shared/code/python.nix
            ./shared/code/rust.nix
            ./shared/editor/emacs.nix
            ./shared/editor/neovim.nix
          ];

        };
        "cachy" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./hosts/cachy/home.nix
            ./hosts/cachy/programs.nix
            ./hosts/cachy/configuration.nix
            ./shared/code/python.nix
            ./shared/code/rust.nix
            ./shared/editor/emacs.nix
            ./shared/editor/neovim.nix
          ];
        };
      };
    };
}

{
  description = "Elian's home-manager configuration";

  inputs = {
    lix-module = {
      url =
        "https://git.lix.systems/lix-project/nixos-module/archive/2.93.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

  outputs = { self, nixpkgs, nix-darwin, home-manager, lix-module, ... }@inputs:
    let
      pkgsDarwin = nixpkgs.legacyPackages.aarch64-darwin;
      pkgsLinux = nixpkgs.legacyPackages.x86_64-linux;
    in {
      # home-manager standalone
      homeConfigurations = {
        "wsl" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsLinux;
          modules = [
            ./hosts/wsl/home.nix
            ./hosts/wsl/configuration.nix
            ./shared/terminal/default.nix
            ./shared/editor/neovim.nix
            ./shared/editor/emacs.nix
            ./shared/code/nix.nix
            ./shared/code/python.nix
            ./shared/code/data.nix
            ./shared/fonts/fonts.nix
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
            ./shared/code/data.nix
            ./shared/editor/emacs.nix
            ./shared/editor/neovim.nix
            ./shared/terminal/default.nix
            ./shared/fonts/fonts.nix
          ];
        };
      };

      # nix-darwina
      darwinConfigurations."elians-MBP" = nix-darwin.lib.darwinSystem {
        modules = [
          ./hosts/mac/configuration.nix
          ./hosts/mac/system.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.elian = import ./hosts/mac/home.nix;
          }
        ];
      };

      # NixOS
      nixosConfigurations.elian-nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/nixos/configuration.nix
          lix-module.nixosModules.default

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.elian = ./hosts/nixos/home.nix;
            home-manager.backupFileExtension = "backup";
          }
        ];
      };
    };
}

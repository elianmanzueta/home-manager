{
  description = "Home Manager configuration of elian";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations = {
        "elian-wsl" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./hosts/wsl/home.nix
            ./hosts/wsl/programs.nix

          ];

        };
      };
    };
}

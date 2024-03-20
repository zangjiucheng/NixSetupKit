{
  description = "Jiucheng's darwin system(MacOS) and NixOS";

  inputs = {
    #nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.11-darwin";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
       #url = github:nix-community/home-manager/release-23.11;
       url = github:nix-community/home-manager;
       inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    }; 
  };

  outputs = { self, nixpkgs, home-manager, nix-darwin, ... }@attrs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      specialArgs = attrs;
      modules = [
	./nixos/configuration.nix
	home-manager.nixosModules.default
	];
    };
    
    darwinConfigurations.macos = nix-darwin.lib.darwinSystem {
      modules = [ ./nixpkgs/darwin-configuration.nix ];
    };
    darwinPackages = self.darwinConfigurations.macos.pkgs;
  };
}

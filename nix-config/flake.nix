{
  description = "Jiucheng's nix-config for MacOS and NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    #nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nixos.url = "nixpkgs/24.11-beta";
    home-manager = {
      url = github:nix-community/home-manager/release-24.11;
      inputs.nixpkgs.follows = "nixpkgs";
    };  
    ghostty = {
      url = "github:ghostty-org/ghostty";
    };
  };

  outputs = { self, nix-darwin, nixpkgs, home-manager, nixos, ghostty, ... }@attrs: {
    nixosConfigurations.nixos-arm = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      specialArgs = attrs;
      modules = [
        ./modules/nixos-aarch64/configuration.nix
        home-manager.nixosModules.default
      ];
    };

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [
        ./modules/nixos-x86/configuration.nix
        home-manager.nixosModules.default
      ];
    };

    nixosConfigurations.server = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [
        ./modules/server/server-configuration.nix
        home-manager.nixosModules.default
      ];
    };

    darwinConfigurations.macos = nix-darwin.lib.darwinSystem {
      modules = [ 
	      ./modules/darwin/darwin-configuration.nix 
        home-manager.darwinModules.default
      ];
    };
  };
}

{
  inputs = {	
        #nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

	home-manager = {
           #url = github:nix-community/home-manager/release-23.11;
	   url = github:nix-community/home-manager;
	   inputs.nixpkgs.follows = "nixpkgs";
	};
  };

  outputs = { self, nixpkgs, home-manager, ... }@attrs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      specialArgs = attrs;
      modules = [ 
	./configuration.nix
	home-manager.nixosModules.default
	];
    };
  };
}

{
  inputs = {
	home-manager = {
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
  	#home-manager.nixosModules.home-manager
        #{
        #  home-manager.useGlobalPkgs = true;
        #  home-manager.useUserPackages = true;
        #}
	];
    };
  };
}

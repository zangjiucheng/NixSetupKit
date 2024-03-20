{
  description = "Jiucheng's darwin system(MacOS)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.11-darwin";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }: {
    darwinConfigurations.macos = nix-darwin.lib.darwinSystem {
      modules = [ ./darwin-configuration.nix ];
    };
    darwinPackages = self.darwinConfigurations.macos.pkgs;
  };
}



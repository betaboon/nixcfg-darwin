{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, ... }:
  let

    inherit (inputs.nix-darwin.lib) darwinSystem;

  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#macosvm
    darwinConfigurations.macosvm = darwinSystem {
      modules = [ 
        ./configuration.nix
        # home-manager specific
        inputs.home-manager.darwinModules.default
        {
          users.users.betaboon.home = "/Users/betaboon";
          home-manager.users.betaboon = import ./home.nix;
        }
        # nix-darwin specific
        {
          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 4;

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = "x86_64-darwin";
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations.macosvm.pkgs;
  };
}

{
  description = "Home Manager Config";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, neovim-nightly-overlay, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      overlays = [ neovim-nightly-overlay.overlays.default ];
      pkgs = import nixpkgs {
        inherit system;
	overlays = overlays;
      };
    in {
      homeConfigurations = {
        bumblebee = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
        };
      };
    };
}

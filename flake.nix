{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    pkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    aagl.url = "github:ezKEa/aagl-gtk-on-nix/release-24.11";
    aagl.inputs.nixpkgs.follows = "nixpkgs";
    inputs.sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      pkgs-unstable,
      home-manager,
      sops-nix,
      aagl,
      ...
    }@inputs:
    let
      inherit (self) outputs;
    in
    {
      nixosConfigurations = {
        niflheim = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
            ./hosts/niflheim/configuration.nix
            home-manager.nixosModules.home-manager
            aagl.nixosModules.default
            sops-nix.nixosModules.sops
          ];
        };

        vanaheim = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs pkgs-unstable;
          };
          modules = [
            ./hosts/vanaheim/configuration.nix
          ];
        };

        alfheim = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
            ./hosts/alfheim/configuration.nix
            sops-nix.nixosModules.sops
          ];
        };
      };

      homeConfigurations = {
        "bunny@niflheim" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs;
          };
          modules = [ ./home-manager/bunny.nix ];
        };

        "bunny@vanaheim" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs;
          };
          modules = [ ./home-manager/bunny.nix ];
        };
      };
    };
}

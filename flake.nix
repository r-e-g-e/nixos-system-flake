{
  description = "Your new nix config";

  inputs = {
    # Darwin
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-24.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs-darwin";

    # Linux X86-64
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    aagl.url = "github:ezKEa/aagl-gtk-on-nix/release-24.11";
    aagl.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      sops-nix,
      aagl,
      nix-darwin,
      nixpkgs-darwin,
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
            inherit inputs outputs nixpkgs-unstable;
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

      darwinConfigurations = {
        midgard = nix-darwin.lib.darwinSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [ ./hosts/midgard/configurationDarwin.nix ];
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

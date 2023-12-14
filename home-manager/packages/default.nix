{ pkgs ? import <nixpkgs> { } }: rec {
  dunst = pkgs.callPackage ./dunst.nix { }; 
  greetd = pkgs.callPackage ./greetd.nix { }; 
  hyprland = pkgs.callPackage ./hyprland.nix { }; 
  vscodium = pkgs.callPackage ./vscodium.nix { }; 
}
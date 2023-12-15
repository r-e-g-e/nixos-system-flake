{ pkgs ? import <nixpkgs> { } }: rec {
  dunst = pkgs.callPackage ./dunst.nix { }; 
  hyprland = pkgs.callPackage ./hyprland.nix { }; 
  vscodium = pkgs.callPackage ./vscodium.nix { }; 
}
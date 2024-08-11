# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{
  inputs,
  pkgs,
  ...
}:
{
  # You can import other home-manager modules here

  imports = [
    inputs.astal.homeManagerModules.default
    ./configs/hyprland.nix
    ./configs/vscodium.nix
    ./configs/niflheimCommon.nix
  ];

  home = {
    username = "bunny";
    homeDirectory = "/home/bunny";
    packages =
      (with pkgs; [
        thunderbird
        webcord
        any-nix-shell
        blender
        dbeaver-bin
        lutris
        logseq
        discord
      ])
      ++ (with inputs.pkgs-unstable.legacyPackages."${pkgs.system}"; [
        hoppscotch
      ]);
    file = {
      "~/.config/neofetch/config.conf".source = ./configs/neofetch.conf;
    };
  };

  services.blueman-applet.enable = true;

  programs.git = {
    enable = true;
    userName = "Rodrigo Tavares";
    userEmail = "rodrigo.tavares.lima@hotmail.com";
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}

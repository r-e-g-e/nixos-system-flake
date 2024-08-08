# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
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
    packages = (with pkgs; [
      thunderbird
      webcord
      any-nix-shell
      blender
      dbeaver
      lutris
      logseq
    ]) ++ (with inputs.pkgs-unstable.legacyPackages."${pkgs.system}"; [
      hoppscotch
    ]);
    file = {
      "~/.config/neofetch/config.conf".source = ./configs/neofetch.conf;
    };
  };

  services.dunst = {
    enable = true;
    configFile = ./configs/dunstrc;
  };

  services.blueman-applet.enable = true;

  programs.astal = {
    enable = true;
    extraPackages = [
      pkgs.libadwaita
    ];
  };

  programs.git = {
    enable = true;
    userName = "Rodrigo Tavares";
    userEmail = "rodrigo.tavares.lima@hotmail.com";
  };
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}

# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
let
  gtkConfig = ''
    [Settings]
    gtk-application-prefer-dark-theme=1
  '';
in
{
  # You can import other home-manager modules here

  imports = [
    ./configs/hyprland.nix
    ./configs/vscodium.nix
    ./configs/niflheimCommon.nix
    ./configs/waybar.nix
  ];

  nixpkgs = {
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "baldur";
    homeDirectory = "/home/baldur";
    packages = with pkgs; [
      webcord
      docker-compose
      any-nix-shell
      insomnia
      dbeaver-bin
    ];
    file = {
      "~/.config/neofetch/config.conf".source = ./configs/neofetch.conf;
    };
  };

  services.dunst = {
    enable = true;
    configFile = ./configs/dunstrc;
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

# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:let 
  gtkConfig = ''
  [Settings]
  gtk-application-prefer-dark-theme=1
  '';
in  {
  # You can import other home-manager modules here

  imports = [
    ./configs/hyprland.nix
    ./configs/vscodium.nix
    ./configs/waybar.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];

    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "bunny";
    homeDirectory = "/home/bunny";
    packages = [
      pkgs.discord
      pkgs.docker-compose
      pkgs.any-nix-shell
      pkgs.blender
    ];
    file = {
      "~/.config/neofetch/config.conf".source = ./configs/neofetch.conf;
      "~/.config/gtk-2.0/config.ini".text = gtkConfig;
      "~/.config/gtk-3.0/config.ini".text = gtkConfig;
      "~/.config/gtk-4.0/config.ini".text = gtkConfig;
    };
  };

  services.dunst = {
    enable = true;
    configFile = ./configs/dunstrc;
  };

  services.blueman-applet.enable = true;

  programs.firefox.enable = true;
  programs.alacritty.enable = true;
  programs.neovim.enable = true;
  programs.home-manager.enable = true;
  programs.bat = {
    enable = true;
    config = {};
  };
  programs.git = {
    enable = true;
    userName = "Rodrigo Tavares";
    userEmail = "rodrigo.tavares.lima@hotmail.com";
  };
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
  };
  programs.fish = {
    enable = true;
    shellAliases = {
      ".." = "cd ..";
    };
    interactiveShellInit = ''
      set fish_greeting
      any-nix-shell fish --info-right | source
    '';
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}


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
    inputs.astal.homeManagerModules.default
    ./configs/hyprland.nix
    ./configs/vscodium.nix
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
      dbeaver
    ];
    file = {
      "~/.config/neofetch/config.conf".source = ./configs/neofetch.conf;
      "~/.config/gtk-2.0/config.ini".text = gtkConfig;
      "~/.config/gtk-3.0/config.ini".text = gtkConfig;
      "~/.config/gtk-4.0/config.ini".text = gtkConfig;
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Breeze-Dark";
      package = pkgs.libsForQt5.breeze-gtk;
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
    style = {
      name = "Breeze-Dark";
      package = pkgs.libsForQt5.breeze-gtk;
    };
  };

  programs.astal = {
    enable = true;
    extraPackages = [
      pkgs.libadwaita
    ];
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

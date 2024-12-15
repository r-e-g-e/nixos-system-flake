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
    ./configs/hyprland.nix
    ./configs/vscodium.nix
    ./configs/niflheimCommon.nix
    ./configs/waybar.nix
  ];

  nixpkgs.config.permittedInsecurePackages = [ "electron-27.3.11" ]; #For LogSeq

  home = {
    username = "bunny";
    homeDirectory = "/home/bunny";
    packages = (
      with pkgs;
      [
        thunderbird
        any-nix-shell
        blender
        dbeaver-bin
        discord
        logseq
        home-manager
      ]
    );
    file = {
      "~/.config/neofetch/config.conf".source = ./configs/neofetch.conf;
    };
  };

  services.blueman-applet.enable = true;

  programs.git = {
    enable = true;
    userName = "Rodrigo Tavares";
    userEmail = "rodrigo@noxis.com.br";
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}

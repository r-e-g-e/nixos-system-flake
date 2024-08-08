
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./configs/waybar.nix
    ./configs/hyprland.nix
    ./configs/vscodium.nix
    ./configs/niflheimCommon.nix
  ];

  home = {
    username = "kolab";
    homeDirectory = "/home/kolab";
    packages = (with pkgs; [
      webcord
      discord
      dbeaver
      mysql-workbench
      logseq
      slack

      any-nix-shell
    ]) ++ (with inputs.pkgs-unstable.legacyPackages."${pkgs.system}"; [
      hoppscotch
    ]);
  };

  programs.git = {
    enable = true;
    userName = "Rodrigo Tavares";
    userEmail = "rodrigo.tavares@kolab.com.br";
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
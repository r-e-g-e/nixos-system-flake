{
  pkgs,
  ...
}:
{
  imports = [
    ./configs/hyprland.nix
    ./configs/vscodium.nix
    ./configs/niflheimCommon.nix
  ];

  home = {
    username = "kolab";
    homeDirectory = "/home/kolab";
    packages =
      (with pkgs; [
        webcord
        discord
        dbeaver-bin
        mysql-workbench
        slack
        filezilla
        any-nix-shell
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
  home.stateVersion = "24.05";
}

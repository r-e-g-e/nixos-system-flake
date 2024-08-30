{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    systemd.enable = false;
    systemd.target = "hyprland-session.target";
  };
}

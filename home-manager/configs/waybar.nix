{pkgs, ...}:{
  programs.waybar = {
    enable = false;
    systemd.enable = true;
    systemd.target = "hyprland-session.target";
  };
}
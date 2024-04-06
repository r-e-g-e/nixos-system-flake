{inputs, pkgs, ...}: {
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland.enable = true;
    enableNvidiaPatches = false;
    systemd.enable = true;
    settings = {
      exec-once = ["asztal"];
      monitor="HDMI-A-1,1920x1080,0x0,1";
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;
      };
      general = {
        gaps_in = 2;
        gaps_out = 2;
        border_size = 2;
        "col.active_border" = "rgb(461c99) rgb(901cfc) rgb(ab14d9) 45deg";
        "col.inactive_border" = "0xff444444";
        no_border_on_floating = false;
        layout = "dwindle";
      };
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = false;
        mouse_move_enables_dpms = true;
        enable_swallow = true;
        swallow_regex = "^(wezterm)$";
      };

      decoration = {
        rounding = 8;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        drop_shadow = true;
        shadow_ignore_window = true;
        shadow_offset = "0 0";
        shadow_range = 0;
        shadow_render_power = 2;
        "col.shadow" = "0x66000000";
        blurls = ["gtk-layer-shell" "lockscreen"];
      };

      animations = {
        enabled = true;

        bezier = [
          "overshot, 0.05, 0.9, 0.1, 1.05" 
          "smoothOut, 0.36, 0, 0.66, -0.56"
          "smoothIn, 0.25, 1, 0.5, 1"
        ];

        animation = [
          "windows, 1, 3, overshot, slide"
          "windowsOut, 1, 3, smoothOut, slide"
          "windowsMove, 1, 3, default"
          "border, 1, 3, default"
          "fade, 1, 3, smoothIn"
          "fadeDim, 1, 3, smoothIn"
          "workspaces, 1, 3, default"
        ];
      };

      dwindle = {
        no_gaps_when_only = false;
        pseudotile = true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true; # you probably want this
      };

      windowrule = [
        "float, com.example.wallpaper project"
        "float, org.kde.polkit-kde-authentication-agent-1"
        "float, title:Confirm to replace files"
        "float, file_progress"
        "float, title:File Operation Progress"
        "float, confirm"
        "float, dialog"
        "float, download"
        "float, notification"
        "float, error"
        "float, splash"
        "float, confirmreset"
        "float, title:Open File"
        "float, title:branchdialog"
        "float, Lxappearance"
        "float, Rofi"
        "animation none,Rofi"
        "float, viewnior"
        "float, Viewnior"
        "float, pavucontrol-qt"
        "float, pavucontrol"
        "float, file-roller"
        "fullscreen, wlogout"
        "float, title:wlogout"
        "fullscreen, title:wlogout"
        "idleinhibit focus, mpv"
        "idleinhibit fullscreen, firefox"
        "idleinhibit fullscreen, firefox-developer-edition"
        "float, title:^(Media viewer)$"
        "float, title:^(Volume Control)$"
        "float, title:^(Picture-in-Picture)$"
        "size 600 400, title:^(Volume Control)$"
        "workspace 4, discord"
        "workspace special, Spotify"
      ];

      bind = [
        "CTRL ALT, L, exec, swaylock"
        "SUPER, Return, exec, alacritty"
        "SUPER, W, exec, firefox"
        "SUPER, N, exec, thunar"
        "SUPER, M, exec, codium"
        "SUPER, D, exec, sh ~/.config/waybar/scripts/launcher.sh"
        "SUPERSHIFT, P, exec,  sh ~/.config/waybar/scripts/power-profiles"
        "SUPER, E, exec, rofi -modi emoji -show emoji -theme ~/.config/waybar/scripts/rofi/emoji.rasi"
        "SUPER SHIFT, E, exec, sh ~/.config/waybar/scripts/powermenu.sh"
        "SUPER SHIFT, P, exec, sh ~/.config/waybar/scripts/"

        ###########################
        # Volume and brightness  #
        ##########################

        #Volume
        ",XF86AudioRaiseVolume,exec,pamixer -i 5"
        ",XF86AudioLowerVolume,exec,pamixer -d 5"
        ",XF86AudioMute,exec,pamixer -t"
        # brightness
        ",XF86MonBrightnessUp,exec,brightnessctl set 100+"
        ",XF86MonBrightnessDown,exec,brightnessctl set 100-"


        ################################## Window Management ###########################################
        "SUPER, Q, killactive"
        # "SUPER SHIFT, Q, exit"
        "SUPER, F, fullscreen"
        "SUPER SHIFT, Space, togglefloating"
        "SUPER, P, pseudo" # dwindle
        "SUPER, S, togglesplit" # dwindle

        ################################## Focus ###########################################
        "SUPER, H, movefocus, l"
        "SUPER, L, movefocus, r"
        "SUPER, K, movefocus, u"
        "SUPER, J, movefocus, d"
        #################################### Keys focus
        "SUPER, right, movefocus, l"
        "SUPER, left, movefocus, r"
        "SUPER, up, movefocus, u"
        "SUPER, down, movefocus, d"
        ################################## Move ###########################################
        "SUPER SHIFT, H, movewindow, l"
        "SUPER SHIFT, L, movewindow, r"
        "SUPER SHIFT, K, movewindow, u"
        "SUPER SHIFT, J, movewindow, d"

        ################################## Resize ###########################################

        "SUPER ALT, h, resizeactive, -50 0"
        "SUPER ALT, l, resizeactive, 50 0"
        "SUPER ALT, k, resizeactive, 0 -50"
        "SUPER ALT, j, resizeactive, 0 50"

        ################################## Switch workspaces ###########################################

        "SUPER CTRL, h, workspace, e-1"
        "SUPER CTRL, l, workspace, e+1"
        "SUPER CTRL, up, resizeactive, 0 -20"
        "SUPER CTRL, down, resizeactive, 0 20"

        ################################## Tabbed ###########################################

        "SUPER, g, togglegroup"
        "SUPER, tab, changegroupactive"

        ################################## Special workspace ###########################################
        "SUPER, x, togglespecialworkspace"
        "SUPERSHIFT, x, movetoworkspace, special"

        ################################## Switch workspace ###########################################

        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"
        "SUPER, 0, workspace, 10"
        "SUPER ALT, up, workspace, e+1"
        "SUPER ALT, down, workspace, e-1"

        ################################## Move window to workspace ###########################################

        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"
        "SUPER SHIFT, 6, movetoworkspace, 6"
        "SUPER SHIFT, 7, movetoworkspace, 7"
        "SUPER SHIFT, 8, movetoworkspace, 8"
        "SUPER SHIFT, 9, movetoworkspace, 9"
        "SUPER SHIFT, 0, movetoworkspace, 10"

        ################################## Mouse Binding ###########################################
        "SUPER, mouse_down, workspace, e+1"
        "SUPER, mouse_up, workspace, e-1"
      ];

      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];

    };
  };
}
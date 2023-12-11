{...}:{
  home.file."~/.config/hypr/hyprland.conf".text = ''
############################################ Exec #############################################
exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
exec-once = systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
exec-once = echo us > /tmp/kb_layout
exec-once = dunst
exec-once = waybar
exec-once = hyprpaper

############################################## Monitor #############################################

monitor=,preferred,auto,1

############################################# Input #############################################

input {
  kb_layout = us
  follow_mouse = 1
  sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
}

############################################# General #############################################

general {
  gaps_in=5
  gaps_out=5
  border_size=2
  col.active_border = rgb(461c99) rgb(901cfc) rgb(ab14d9) 45deg
  col.inactive_border = 0xff444444
  no_border_on_floating = false
  layout = dwindle
}

############################################# Misc #############################################

misc {
  disable_hyprland_logo = true
  disable_splash_rendering = true
  mouse_move_enables_dpms = true
  enable_swallow = true
  swallow_regex = ^(wezterm)$
}

############################################# Decorations #############################################

decoration {

############################################# Rounded Corner #############################################

  rounding = 8
  multisample_edges = true

############################################# Opacity #############################################

  active_opacity = 1.0
  inactive_opacity = 1.0

############################################# Shadow #############################################

  drop_shadow = true
  shadow_ignore_window = true
  shadow_offset = 0 0
  shadow_range = 0
  shadow_render_power = 2
  col.shadow = 0x66000000

  blurls = gtk-layer-shell
  # blurls = waybar
  blurls = lockscreen
}

############################################# Animations #############################################

animations {
  enabled = true

############################################# Bezier Curve #############################################

  bezier = overshot, 0.05, 0.9, 0.1, 1.05
  bezier = smoothOut, 0.36, 0, 0.66, -0.56
  bezier = smoothIn, 0.25, 1, 0.5, 1

  animation = windows, 1, 3, overshot, slide
  animation = windowsOut, 1, 3, smoothOut, slide
  animation = windowsMove, 1, 3, default
  animation = border, 1, 3, default
  animation = fade, 1, 3, smoothIn
  animation = fadeDim, 1, 3, smoothIn
  animation = workspaces, 1, 3, default

}

############################################ Layouts ###################################################

dwindle {
  no_gaps_when_only = false
  pseudotile = true # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
  preserve_split = true # you probably want this
}

############################################## Window Rules #####################################################
windowrule = float, com.example.wallpaper project
windowrule = float, org.kde.polkit-kde-authentication-agent-1
windowrule = float, title:Confirm to replace files
windowrule = float, file_progress
windowrule = float, title:File Operation Progress
windowrule = float, confirm
windowrule = float, dialog
windowrule = float, download
windowrule = float, notification
windowrule = float, error
windowrule = float, splash
windowrule = float, confirmreset
windowrule = float, title:Open File
windowrule = float, title:branchdialog
windowrule = float, Lxappearance
windowrule = float, Rofi
windowrule = animation none,Rofi
windowrule = float, viewnior
windowrule = float, Viewnior
windowrule = float, pavucontrol-qt
windowrule = float, pavucontrol
windowrule = float, file-roller
windowrule = fullscreen, wlogout
windowrule = float, title:wlogout
windowrule = fullscreen, title:wlogout
windowrule = idleinhibit focus, mpv
windowrule = idleinhibit fullscreen, firefox
windowrule = idleinhibit fullscreen, firefox-developer-edition
windowrule = float, title:^(Media viewer)$
windowrule = float, title:^(Volume Control)$
windowrule = float, title:^(Picture-in-Picture)$
windowrule = size 600 400, title:^(Volume Control)$

## Assign applications to certain workspaces

#windowrule = workspace 1, Alacritty
#windowrule = workspace 2, firefox
#windowrule = workspace 3, Codium
windowrule = workspace 8, discord
windowrule = workspace special, Spotify

########################################### Key Bind #######################################

########################################### Screen Shot ###################################
bind = , Print, exec, grim $(xdg-user-dir PICTURES)/$(date +'%s.png') && exec ~/.config/hypr/scripts/screenshot_notify
bind = SUPERSHIFT, S, exec, grim  -g "$(slurp)" ~/Pictures/Screenshots/$(date +"Screenshot_%Y-%m-%d_%H-%M-%S.png") && exec ~/.config/hypr/scripts/screenshot_notify


########################################## Misc ###########################################
bind = CTRL ALT, L, exec, swaylock
bind = SUPER, Return, exec,alacritty
bind = SUPER, W, exec, firefox
bind = SUPER, N, exec, thunar
bind = SUPER, M, exec, codium
bind = SUPER, D, exec, sh ~/.config/waybar/scripts/launcher.sh
bind = SUPERSHIFT, P, exec,  sh ~/.config/waybar/scripts/power-profiles
bind = SUPER, E, exec, rofi -modi emoji -show emoji -theme ~/.config/waybar/scripts/rofi/emoji.rasi
bind = SUPER SHIFT, E, exec, sh ~/.config/waybar/scripts/powermenu.sh
bind = SUPER SHIFT, P, exec, sh ~/.config/waybar/scripts/

###########################
# Volume and brightness  #
##########################

#Volume
bind=,XF86AudioRaiseVolume,exec,pamixer -i 5
bind=,XF86AudioLowerVolume,exec,pamixer -d 5
bind=,XF86AudioMute,exec,pamixer -t
# brightness
bind=,XF86MonBrightnessUp,exec,brightnessctl set 100+
bind=,XF86MonBrightnessDown,exec,brightnessctl set 100-


################################## Window Management ###########################################
bind = SUPER, Q, killactive,
# bind = SUPER SHIFT, Q, exit,
bind = SUPER, F, fullscreen,
bind = SUPER SHIFT, Space, togglefloating,
bind = SUPER, P, pseudo, # dwindle
bind = SUPER, S, togglesplit, # dwindle

################################## Focus ###########################################
bind = SUPER, H, movefocus, l
bind = SUPER, L, movefocus, r
bind = SUPER, K, movefocus, u
bind = SUPER, J, movefocus, d
#################################### Keys focus
bind = SUPER, right, movefocus, l
bind = SUPER, left, movefocus, r
bind = SUPER, up, movefocus, u
bind = SUPER, down, movefocus, d
################################## Move ###########################################
bind = SUPER SHIFT, H, movewindow, l
bind = SUPER SHIFT, L, movewindow, r
bind = SUPER SHIFT, K, movewindow, u
bind = SUPER SHIFT, J, movewindow, d

################################## Resize ###########################################

bind = SUPER ALT, h, resizeactive, -50 0
bind = SUPER ALT, l, resizeactive, 50 0
bind = SUPER ALT, k, resizeactive, 0 -50
bind = SUPER ALT, j, resizeactive, 0 50

################################## Switch workspaces ###########################################

bind = SUPER CTRL, h, workspace, e-1
bind = SUPER CTRL, l, workspace, e+1
bind = SUPER CTRL, up, resizeactive, 0 -20
bind = SUPER CTRL, down, resizeactive, 0 20

################################## Tabbed ###########################################

bind= SUPER, g, togglegroup
bind= SUPER, tab, changegroupactive

################################## Special workspace ###########################################
bind = SUPER, x, togglespecialworkspace
bind = SUPERSHIFT, x, movetoworkspace, special

################################## Switch workspace ###########################################

bind = SUPER, 1, workspace, 1
bind = SUPER, 2, workspace, 2
bind = SUPER, 3, workspace, 3
bind = SUPER, 4, workspace, 4
bind = SUPER, 5, workspace, 5
bind = SUPER, 6, workspace, 6
bind = SUPER, 7, workspace, 7
bind = SUPER, 8, workspace, 8
bind = SUPER, 9, workspace, 9
bind = SUPER, 0, workspace, 10
bind = SUPER ALT, up, workspace, e+1
bind = SUPER ALT, down, workspace, e-1

################################## Move window to workspace ###########################################

bind = SUPER SHIFT, 1, movetoworkspace, 1
bind = SUPER SHIFT, 2, movetoworkspace, 2
bind = SUPER SHIFT, 3, movetoworkspace, 3
bind = SUPER SHIFT, 4, movetoworkspace, 4
bind = SUPER SHIFT, 5, movetoworkspace, 5
bind = SUPER SHIFT, 6, movetoworkspace, 6
bind = SUPER SHIFT, 7, movetoworkspace, 7
bind = SUPER SHIFT, 8, movetoworkspace, 8
bind = SUPER SHIFT, 9, movetoworkspace, 9
bind = SUPER SHIFT, 0, movetoworkspace, 10

################################## Mouse Binding ###########################################
bindm = SUPER, mouse:272, movewindow
bindm = SUPER, mouse:273, resizewindow
bind = SUPER, mouse_down, workspace, e+1
bind = SUPER, mouse_up, workspace, e-1
  '';
}
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
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./packages/dunst.nix
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
    packages = with pkgs; [
      steam
      discord
    ];
    file = {
      ".config/gtk-2.0/config.ini".text = gtkConfig;
      ".config/gtk-3.0/config.ini".text = gtkConfig;
      ".config/gtk-4.0/config.ini".text = gtkConfig;
      ".config/dunst/dunstrc" = ''
      [global]
          font = JetbrainsMono NF 11
          word_wrap = yes
          markup = full
          follow = mouse
          offset = 20x24

          width = (0, 500)
          corner_radius = 10

          timeout = 5
          show_age_threshold = 60
          stack_duplicates = true
          hide_duplicate_count = false
          show_indicators = no
          indicate_hidden = yes

          frame_width = 2
          progress_bar_frame_width = 0
          progress_bar_corner_radius = 5

          min_icon_size = 0
          max_icon_size = 80
          icon_corner_radius = 5
          text_icon_padding = 10

          dmenu = /usr/bin/rofi -p dunst:
          browser = /usr/bin/firefox --new-tab

          mouse_left_click = do_action
          mouse_middle_click = close_all
          mouse_right_click = close_current

      [urgency_low]
          background = "#!!{primary}88"
          foreground = "#!!text"
          frame_color = "#!!accent"

      [urgency_normal]
          background = "#!!{primary}88"
          foreground = "#!!text"
          frame_color = "#!!accent"

      [urgency_critical]
          background = "#!!{primary}88"
          foreground = "#!!text"
          frame_color = "#!!accent"
            '';
    };
  };

    wayland.windowManager.hyprland.enable = true;
  services.dunst.enable = true;
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = true;
    keybindings = [
      # {
      #   key = "";
      #   command = "";
      #   when = "";
      # }
    ];
    userSettings = {
      "telemetry.telemetryLevel" = "off";
      "telemetry.enableCrashReporter" = false;
      "telemetry.enableTelemetry" = false;
      "editor.fontFamily" = "'victor mono', 'victor-mono', 'monospace', monospace";
      "editor.fontLigatures" = true;
    };
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      esbenp.prettier-vscode
      rust-lang.rust-analyzer
      pkief.material-icon-theme
      donjayamanne.githistory
      waderyan.gitblame
      editorconfig.editorconfig
    ];
  };

  programs.alacritty.enable = true;
  programs.neovim.enable = true;
  programs.firefox.enable = true;
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}

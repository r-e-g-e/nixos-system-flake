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
      discord
    ];
    file = {
      "~/.config/neofetch/config.conf".source = ./configs/neofetch.conf;
      "~/.config/hypr/hyprland.conf".source = ./configs/hyprland.conf;
      "~/.config/gtk-2.0/config.ini".text = gtkConfig;
      "~/.config/gtk-3.0/config.ini".text = gtkConfig;
      "~/.config/gtk-4.0/config.ini".text = gtkConfig;
    };
  };

  services.dunst = {
    enable = true;
    configFile = ./configs/dunstrc;
  };
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium-fhs;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = true;
    keybindings = [
      {
        key = "ctrl+'";
        command = "workbench.action.terminal.toggleTerminal";
        when = "terminal.active";
      }
      {
        key = "ctrl+`";
        command = "-workbench.action.terminal.toggleTerminal";
        when = "terminal.active";
      }
      {
        key = "ctrl+h";
        command = "workbench.action.previousEditor";
      }
      {
        key = "ctrl+pageup";
        command = "-workbench.action.previousEditor";
      }
      {
        key = "ctrl+l";
        command = "workbench.action.nextEditor";
      }
      {
        key = "ctrl+pagedown";
        command = "-workbench.action.nextEditor";
      }
      {
        key = "shift+alt+/";
        command = "editor.action.commentLine";
        when = "editorTextFocus && !editorReadonly";
      }
      {
        key = "ctrl+/";
        command = "-editor.action.commentLine";
        when = "editorTextFocus && !editorReadonly";
      }
      {
        key = "shift+alt+a";
        command = "editor.action.blockComment";
        when = "editorTextFocus && !editorReadonly";
      }
      {
        key = "ctrl+shift+a";
        command = "-editor.action.blockComment";
        when = "editorTextFocus && !editorReadonly";
      }
      {
        key = "ctrl+p";
        command = "-extension.vim_ctrl+p";
        when = "editorTextFocus && vim.active && vim.use<C-p> && !inDebugRepl || vim.active && vim.use<C-p> && !inDebugRepl && vim.mode == 'CommandlineInProgress' || vim.active && vim.use<C-p> && !inDebugRepl && vim.mode == 'SearchInProgressMode'";
      }
      {
        key = "ctrl+shift+;";
        command = "editor.action.revealDefinition";
        when = "editorHasDefinitionProvider && editorTextFocus && !isInEmbeddedEditor";
      }
      {
        key = "f12";
        command = "-editor.action.revealDefinition";
        when = "editorHasDefinitionProvider && editorTextFocus && !isInEmbeddedEditor";
      }
    ];
    userSettings = {
      "telemetry.telemetryLevel" = "off";
      "telemetry.enableCrashReporter" = false;
      "telemetry.enableTelemetry" = false;

      "editor.fontFamily" = "'victor mono', 'victor-mono', 'monospace', monospace";
      "editor.fontLigatures" = true;
      "editor.fontWeight" = "bold";
      "editor.lineNumbers" = "relative";
      "editor.minimap.enabled" = false;
      "editor.renderLineHighlight" = "all";
      "editor.semanticHighlighting.enabled" = true;

      "[typescript].editor.defaultFormatter" = "esbenp.prettier-vscode";
      "typescript.preferences.importModuleSpecifier" = "relative";
      "javascript.preferences.importModuleSpecifier" = "relative";
      "workbench.iconTheme" = "material-icon-theme";
      "workbench.startupEditor" = "none";
      "explorer.compactFolders" = false;
      "breadcrumbs.enabled" = false;
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

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    enableNvidiaPatches = false;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  programs.firefox.enable = true;
  programs.alacritty.enable = true;
  programs.neovim.enable = true;
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "Rodrigo Tavares";
    userEmail = "rodrigo.tavares.lima@hotmail.com";
  };
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}

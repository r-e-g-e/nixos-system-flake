{ pkgs, ... }:
{
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

  programs.fish = {
    enable = true;
    shellAliases = {
      ".." = "cd ..";
      "l" = "ls -la";
      "ll" = "ls -l";
    };
    interactiveShellInit = ''
      set fish_greeting
      any-nix-shell fish --info-right | source
    '';
  };

  xdg = {
    # desktopEntries = {
    #   firefox = {
    #     name = "Firefox";
    #     genericName = "Web Browser";
    #     exec = pkgs.firefox;
    #     mimeType = ["text/html" "text/xml"];
    #   }
    # };

    mimeApps = {
      enable = true;
      associations.added = {
        "inode/directory" = "nautilus.desktop";
        "application/pdf" = "firefox.desktop";
        "text/html" = "firefox.desktop";
        "text/xml" = "firefox.desktop";
        # Add your custom mimetype entry for file paths here
        # "text/plain" = "gedit.desktop";  # Example for text files
        # "image/jpeg" = "gthumb.desktop";  # Example for JPEG images
      };
      defaultApplications = {
        "inode/directory" = "nautilus.desktop";
      };
    };

    configFile = {
      "mimeapps.list".force = true;
    };
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };

    "org/gnome/desktop/interface" = {
      gtk-theme = "Breeze-Dark";
      color-scheme = "prefer-dark";
      prefer-dark = true;
    };

    # "org/gnome/shell" = {
    #   disable-user-extensions = false;
    #   enable-extensions = with pkgs.gnomeExtensions; [
    #     blur-my-shell
    #     appindicator
    #     permanent-notifications
    #   ];
    # };
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "oreo_spark_violet_cursors";
    package = pkgs.oreo-cursors-plus;
    size = 16;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Breeze-Dark";
      package = pkgs.libsForQt5.breeze-gtk;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "lavender";
      };
    };
    cursorTheme = {
      name = "oreo_spark_violet_cursors";
      package = pkgs.oreo-cursors-plus;
    };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style = {
      name = "gtk2";
      package = pkgs.libsForQt5.breeze-qt5;
    };
  };

  programs.firefox.enable = true;
  programs.alacritty.enable = true;
  programs.neovim.enable = true;
  programs.home-manager.enable = true;
  programs.bat = {
    enable = true;
    config = { };
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };
}

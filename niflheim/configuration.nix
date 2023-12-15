# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    ./packages/greetd.nix
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      bunny = {
        home = {
          username = "bunny";
          homeDirectory = "/home/bunny";
          stateVersion = "23.05";
        };

        # Nicely reload system units when changing configs
        systemd.user.startServices = "sd-switch";

        services.dusnt = {
          enable = true;
          settings = {
            global = {
              font = "JetbrainsMono NF 11";
              word_wrap = "yes";
              markup = "full";
              follow = "mouse";
              offset = "20x24";
            };

            width = "(0, 500)";
            corner_radius = 10;

            timeout = 5;
            show_age_threshold = 60;
            stack_duplicates = true;
            hide_duplicate_count = false;
            show_indicators = "no";
            indicate_hidden = "yes";

            frame_width = 2;
            progress_bar_frame_width = 0;
            progress_bar_corner_radius = 5;

            min_icon_size = 0;
            max_icon_size = 80;
            icon_corner_radius = 5;
            text_icon_padding = 10;

            dmenu = "/usr/bin/rofi -p dunst";
            browser = "/usr/bin/firefox --new-tab";

            mouse_left_click = "do_action";
            mouse_middle_click = "close_all";
            mouse_right_click = "close_current";

            urgency_low = {
              background = "#!!{primary}88";
              foreground = "#!!text";
              frame_color = "#!!accent";
            };
            urgency_normal = {
              background = "#!!{primary}88";
              foreground = "#!!text";
              frame_color = "#!!accent";
            };
            urgency_critical = {
              background = "#!!{primary}88";
              foreground = "#!!text";
              frame_color = "#!!accent";
            };
          };
        };

        programs.neovim.enable = true;
        programs.home-manager.enable = true;
        programs.git.enable = true;
      };
    };
  };




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
    config.allowUnfree = true;
  };

  # This will add each flake input as a registry
  # To make nix3 commands consistent with your flake
  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  nix = {
    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = ["/etc/nix/path"];
    settings = {
      # Nix binary cache URLs
      substituters = [ "https://cache.nixos.org/" "https://hyprland.cachix.org/" ];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
  };
  environment.etc =
    lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;

  nix.settings = {
    # Enable flakes and new 'nix' command
    experimental-features = ["nix-command" "flakes"];
    # Deduplicate and optimize nix store
    auto-optimise-store = true;
  };

  networking.hostName = "niflheim";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Sao_Paulo";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = { 
      LC_ADDRESS = "pt_BR.UTF-8";
      LC_IDENTIFICATION = "pt_BR.UTF-8";
      LC_MEASUREMENT = "pt_BR.UTF-8";
      LC_MONETARY = "pt_BR.UTF-8";
      LC_NAME = "pt_BR.UTF-8";
      LC_NUMERIC = "pt_BR.UTF-8";
      LC_PAPER = "pt_BR.UTF-8";
      LC_TELEPHONE = "pt_BR.UTF-8";
      LC_TIME = "pt_BR.UTF-8";
    };
  };


  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.displayManager.defaultSession = "plasmawayland";
  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
    elisa
    gwenview
    okular
    oxygen
    khelpcenter
    konsole
    plasma-browser-integration
    print-manager
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };
  programs.fish.enable = true;
  programs.ssh.startAgent = true;

  users.users = {
    bunny = {
      initialPassword = "password";
      isNormalUser = true;
      description = "BunnY";
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = [];
      extraGroups = [ "networkmanager" "wheel" "docker" "disk"];
      packages = [ inputs.home-manager.packages.${pkgs.system}.default ];
    };
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" "DroidSansMono" ];})
    jetbrains-mono
    noto-fonts-emoji
    victor-mono
  ];

  services.openssh = {
    enable = false;
    settings = {
      # Forbid root login through SSH.
      PermitRootLogin = "no";
      # Use keys only. Remove if you want to SSH using password (not recommended)
      PasswordAuthentication = false;
    };
  };

  environment.systemPackages = with pkgs; [
    neovim
    git
    htop
    any-nix-shell
  ];
   
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # RTKIT pipewire related.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  virtualisation = {
    # following configuration is added only when building VM with build-vm
    vmVariant.virtualisation = {
      memorySize = 2048;
      cores = 4;
    };

    docker = {
      enable = true;
      enableOnBoot = false;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}


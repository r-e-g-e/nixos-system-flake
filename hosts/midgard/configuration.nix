{ config, lib, pkgs, inputs, outputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    inputs.apple-silicon.nixosModules.apple-silicon-support
  ];

  home-manager = {
    extraSpecialArgs = {
      inherit inputs outputs;
    };
    users = {
      bunny = import ../../home-manager/bunny.nix;
    };
  };

  hardware.asahi = {
    setupAsahiSound = true;
    useExperimentalGPUDriver = true;
    experimentalGPUInstallMode = "replace";

    # This step should be done manually:
    # reference: https://github.com/tpwrules/nixos-apple-silicon/issues/299#issuecomment-2901508921
    peripheralFirmwareDirectory = pkgs.requireFile {
      name = "firmware";
      hashMode = "recursive";
      hash = "sha256-xg2ePZvVXJmhCWT9MSwHGSTDDQofI2Tc+vc435A8CyE=";
      message = ''
        nix-store --add-fixed sha256 --recursive /etc/nixos/firmware
      '';
    };
  };

  #polkit configuration to prevent sleep
  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
        if (action.id == "org.freedesktop.login1.suspend" ||
            action.id == "org.freedesktop.login1.suspend-multiple-sessions" ||
            action.id == "org.freedesktop.login1.hibernate" ||
            action.id == "org.freedesktop.login1.hibernate-multiple-sessions")
        {
            return polkit.Result.NO;
        }
    });
  '';

  boot = {
    tmp.cleanOnBoot = true;

    loader = {
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 10;
      efi.canTouchEfiVariables = false; # Doc requirement
      timeout = 2;
    };
  };

  networking.wireless.iwd = {
    enable = true;
    settings.General.EnableNetworkConfiguration = true;
  };

  networking = {
    hostName = "midgard";

    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ];
      allowedUDPPorts = [ ];
    };
  };

  time.timeZone = "America/Sao_Paulo";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
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

  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = true;
    };
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    displayManager.gdm.autoSuspend= false;
    desktopManager.gnome.enable = true;  
  };

  environment.gnome.excludePackages = (
    with pkgs;
    [
      gnome-tour
      gnome-music
      gnome-photos
      totem # video player
      gedit # text editor
      gnome-maps
      cheese # webcam tool
      gnome-terminal
      epiphany # web browser
      geary # email reader
      evince # document viewer
      gnome-characters
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
    ]
  );

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bunny = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
  };


  programs.fish.enable = true;

  services = {
    openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "prohibit-password";
      };
    };

    mysql = {
      enable = false;
      package = pkgs.mariadb;
      user = "angel";
      dataDir = "/var/lib/mysql";
      initialDatabases = [ { name = "noxis"; } ];
    };

    jenkins = {
      enable = false;
      port = 8080;
    };

    gitea = {
      enable = false;
      stateDir = "/var/lib/gitea"; # Data dir (explicit default path)
      database = {
        type = "mysql";
        socket = "";
      };
    };


    nginx = {
      enable = true;
      recommendedProxySettings = true;
      recommendedGzipSettings = false;
      recommendedOptimisation = false;
      virtualHosts = {
        noxis = {
          serverName = "noxis.com.br";
          default = true;
          forceSSL = false;
          locations."/".return = "200 \"Hello from noxis!\"";
        };
        # gitlab = {
        #   serverName = "git.noxis.com.br";
        #   forceSSL = false;
        #   enableACME = false;
        #   locations."/".proxyPass = "http://unix:/run/gitlab/gitlab-workhorse.socket";
        # };
        # jenkins = {
        #   serverName = "ci.noxis.com.br";
        #   forceSSL = false;
        #   enableACME = false;
        #   locations."/".proxyPass = "http://127.0.0.1:8080";
        # };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
  ];

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?
}


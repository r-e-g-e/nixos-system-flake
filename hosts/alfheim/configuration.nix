{
  pkgs,
  config,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../common/nix.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "alfheim";

    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 443 ];
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

  programs.fish.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users = {
      angel = {
        initialPassword = "password";
        isNormalUser = true;
        description = "Angel";
        extraGroups = [
          "wheel"
          "docker"
        ];
        shell = pkgs.fish;
        # openssh.authorizedKeys.keys = readFile ../ssh_keys;
      };

      db = {
        isSystemUser = true;
        group = "db";
      };
    };

    groups.db = {
      name = "db";
      members = [ "db" "angel" ];
    };
  };

  environment.systemPackages = (
    with pkgs;
    [
      neovim
      wget
    ]
  );

  # sops = {
    # age.keyFile = "/home/angel/.config/sops/age/keys.txt";
    # templates = {
    #   "gitlab.yaml".content = ''
    #   gitlab:
    #     - optFile: "asdf"
    #       secretFile: "asdf"
    #       initialRootPasswordFile: "aodsf"
    #       dbFile: "asdfas"
    #       jwsFile: "asfas"
    #   '';
    # };
  #   secrets."postgres/password" = {
  #     owner = "db";
  #     group = "db";
  #     sopsFile = ./.secrets/postgres.yaml;
  #     format = "yaml";
  #   };
  #   secrets."gitlab/optFile" = {
  #     owner = "gitlab";
  #     group = "gitlab";
  #     sopsFile = ./.secrets/gitlab.yaml;
  #     format = "yaml";
  #   };
  #   secrets."gitlab/secretFile" = {
  #     owner = "gitlab";
  #     group = "gitlab";
  #     sopsFile = ./.secrets/gitlab.yaml;
  #     format = "yaml";
  #   };
  #   secrets."gitlab/initialRootPassword" = {
  #     owner = "gitlab";
  #     group = "gitlab";
  #     sopsFile = ./.secrets/gitlab.yaml;
  #     format = "yaml";
  #   };
  #   secrets."gitlab/dbFile" = {
  #     owner = "gitlab";
  #     group = "gitlab";
  #     sopsFile = ./.secrets/gitlab.yaml;
  #     format = "yaml";
  #   };
  #   secrets."gitlab/jwsFile" = {
  #     owner = "gitlab";
  #     group = "gitlab";
  #     sopsFile = ./.secrets/gitlab.yaml;
  #     format = "yaml";
  #   };
  # };

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}

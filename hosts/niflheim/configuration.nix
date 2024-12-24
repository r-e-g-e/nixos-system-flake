# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  pkgs,
  ...
}:
{
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
    # ../common/greetd.nix
    # ../common/passthroughGPU.nix
    ../common/nix.nix
    ../common/fonts.nix
    ../common/logind.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.aagl.nixosModules.default
  ];

  programs.sleepy-launcher.enable = true;

  home-manager = {
    extraSpecialArgs = {
      inherit inputs outputs;
    };
    users = {
      bunny = import ../../home-manager/bunny.nix;
      kolab = import ../../home-manager/kolab.nix;
    };
  };

  networking.hostName = "niflheim";
  networking.networkmanager.enable = true;
  networking.extraHosts = "172.20.128.2 pushstart.hrtech";

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

  boot = {
    tmp.cleanOnBoot = true;

    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
      timeout = 2;
    };

    plymouth = rec {
      enable = true;
      # black_hud circle_hud cross_hud square_hud
      # circuit connect cuts_alt seal_2 seal_3
      theme = "circuit";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [ theme ];
        })
      ];
    };
  };

  services.syncthing.enable = true;
  services.flatpak.enable = true;

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.xserver.desktopManager.plasma5.enable = false;
  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
    plasma-browser-integration
    konsole
    oxygen
  ];
  programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.seahorse.out}/libexec/seahorse/ssh-askpass";

  environment.gnome.excludePackages = (
    with pkgs;
    [
      gnome-tour
      # gnome-music
      # gnome-photos
      # totem # video player
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

  programs.hyprland = {
    enable = true;
  };

  programs.fish.enable = true;
  programs.ssh.startAgent = true;
  programs.steam.enable = true;

  users.users = {
    bunny = {
      initialPassword = "password";
      isNormalUser = true;
      description = "BunnY";
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = [ ];
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
        "disk"
        "libvirtd"
        "syncthing"
      ];
    };
    kolab = {
      initialPassword = "password";
      isNormalUser = true;
      description = "Kolab";
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = [ ];
      extraGroups = [ "docker" ];
    };
  };

  services.blueman.enable = true;
  hardware.pulseaudio.enable = false;
  hardware.graphics.enable32Bit = true;
  hardware.bluetooth = {
    enable = true;
    settings.general.Experimental = true;
    powerOnBoot = true;
  };

  services.openssh = {
    enable = true;
    settings = {
      # Forbid root login through SSH.
      PermitRootLogin = "no";
      # Use keys only. Remove if you want to SSH using password (not recommended)
      PasswordAuthentication = true;
    };
  };

  environment.systemPackages =
    (with pkgs; [
      mdadm
      neovim
      neofetch
      git
      htop
      virt-manager
      virtiofsd
      spice
      spice-gtk
      spice-protocol
      adwaita-icon-theme
      pamixer
      pavucontrol
      slurp
      wf-recorder
      wl-clipboard
      papirus-icon-theme
      nil
      protonvpn-gui
    ])
    ++ (with pkgs.gnomeExtensions; [
      blur-my-shell
      appindicator
      permanent-notifications
    ]);

  xdg.portal = {
    enable = true;
    # extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };

  # RTKIT pipewire related.
  security.rtkit.enable = true;
  security.polkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  programs.virt-manager.enable = true;
  programs.dconf.enable = true;

  virtualisation = {
    # following configuration is added only when building VM with build-vm
    vmVariant.virtualisation = {
      memorySize = 2048;
      cores = 4;
    };

    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = with pkgs; [ OVMFFull.fd ];
      };
    };

    docker = {
      enable = true;
      enableOnBoot = false;
    };
  };

  system.autoUpgrade = {
    enable = true;
    channel = "https://nixos.org/channels/nixos-24.11";
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.11";
}

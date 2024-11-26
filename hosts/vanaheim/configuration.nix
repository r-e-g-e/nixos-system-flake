# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  pkgs,
  inputs,
  outputs,
  ...
}:
{

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../common/nix.nix
    ../common/fonts.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    extraSpecialArgs = {
      inherit inputs outputs;
    };
    users = {
      baldur = import ../../home-manager/vanaheim.nix;
      kolab = import ../../home-manager/kolab.nix;
    };
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    networkmanager = {
      enable = true;
      wifi.powersave = true;
      wifi.backend = "wpa_supplicant";
    };

    hostName = "vanaheim"; # Define your hostname.
    extraHosts = "172.20.128.2 pushstart.hrtech";
  };

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
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

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    desktopManager.plasma5.enable = false;
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.gnome.gnome-keyring.enable = true;
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  environment.plasma5.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    konsole
    oxygen
  ];

  environment.gnome.excludePackages =
    (with pkgs; [
      gnome-tour
      # gnome-music
      # gnome-photos
      # totem # video player
      gedit # text editor
    ])
    ++ (with pkgs.gnome; [
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
    ]);

  # Enable the GNOME Desktop Environment.
  services.blueman.enable = true;
  services.flatpak.enable = true;
  services.syncthing.enable = true;

  xdg.portal = {
    enable = true;
  };

  programs.hyprland = {
    enable = true;
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  hardware.opengl.driSupport32Bit = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };

  programs.fish.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    baldur = {
      isNormalUser = true;
      description = "Baldur";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
        "syncthing"
      ];
      shell = pkgs.fish;
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
  programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.gnome.seahorse.out}/libexec/seahorse/ssh-askpass";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = (with pkgs; [
    rofi-wayland
    rofi-emoji
    xfce.thunar
    brightnessctl
    pamixer
    wl-clipboard
    nil
    protonvpn-gui
  ])
  ++ (with pkgs.gnomeExtensions; [
    blur-my-shell
    appindicator
    permanent-notifications
  ]);

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 
      8384 # Syncthing
    ];
    allowedUDPPorts = [];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}

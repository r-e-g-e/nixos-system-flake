{ pkgs, lib, inputs, ... }: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [ 
    neovim
    fastfetch
  ];

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Enable alternative shell support in nix-darwin.
  programs.fish.enable = true;
  security.pam.enableSudoTouchIdAuth = true;

  # Set Git commit hash for darwin-version.
  # system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  services.yabai = {
    enable = true;
    enableScriptingAddition = true;
    config = {
      layout = "bsp";
      mouse_follows_focus = "on";
      mouse_modifier = "cmd";
      Mouse_action1 = "move";
      mouse_action2 = "resize";
      window_border = "on";
      active_window_border_color = "0xFF88C0D0";
      normal_window_border_color = "0x002E3440";
      window_placement = "second_child";
    };
  };

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}

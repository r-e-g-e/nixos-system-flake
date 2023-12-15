{pkgs, ...}:{
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
      "telemetry" = {
        "telemetryLevel" = "off";
        "enableCrashReporter" = false;
        "enableTelemetry" = false;
      };
      "editor" = { "fontFamily" = "'victor mono', 'victor-mono', 'monospace', monospace";
        "fontLigatures" = true;
      };
    };
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
    ];
  };
}
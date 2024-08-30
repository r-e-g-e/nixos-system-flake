{ pkgs, ... }:
{
  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "JetBrainsMono"
        "DroidSansMono"
      ];
    })
    jetbrains-mono
    noto-fonts-emoji
    victor-mono
    noto-fonts
    noto-fonts-cjk
    azeret-mono
  ];
}

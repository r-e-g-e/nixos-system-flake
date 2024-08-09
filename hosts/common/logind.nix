{ ... }:
{
  services.logind.extraConfig = ''
    HandlePowerKey=suspend
    HandleLidSwitch=suspend
    HandleLidSwitchExternalPower=ignore
  '';
}

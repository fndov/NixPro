{ systemSettings, pkgs, ... }:
{
  networking.hostName = systemSettings.hostname; # Define your hostname.
  networking.networkmanager.enable = true;
  environment.systemPackages = [ pkgs.networkmanagerapplet ];
  programs.nm-applet.enable = true;
}

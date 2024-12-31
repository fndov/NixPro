{ systemSettings, pkgs, ... }: {
  networking.hostName = systemSettings.hostname; # Set in flake.nix
  networking.networkmanager.enable = true;
  environment.systemPackages = [ pkgs.networkmanagerapplet ];
  programs.nm-applet.enable = true;
}

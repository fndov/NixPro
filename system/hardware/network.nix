{ pkgs, ... }: {
  networking.networkmanager.enable = true;
  environment.systemPackages = [ pkgs.networkmanagerapplet ];
  programs.nm-applet.enable = true;
}

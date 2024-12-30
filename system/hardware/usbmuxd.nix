{ pkgs, ... }:
{
  # Move files between PC & IOS.
  services.usbmuxd.enable = true;
  services.usbmuxd.package = pkgs.usbmuxd2;
  environment.systemPackages = with pkgs; [ networkmanagerapplet ifuse ];
}

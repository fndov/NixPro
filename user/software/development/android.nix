{ pkgs, ... }:
{
  # Android.
  home.packages = with pkgs; [
    android-tools
    android-udev-rules
  ];
}

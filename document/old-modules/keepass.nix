{ config, pkgs, ... }:
{
  home.packages = [ pkgs.keepassxc pkgs.keepmenu ]
}

{ pkgs, ... }:
{
  home.packages = with pkgs; [ ssh sshpass ];
}
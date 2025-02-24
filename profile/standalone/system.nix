/* 
  Edit this Configuration file to define what should be installed on
  - your system. Help is available in the configuration.nix(5) man page
  - and in the NixOS manual (accessible by running `nixos-help`). 
*/
{ ... }: {
  imports = [ 
    /* Configuration */
    ../../modules/system/btrfs.nix
  ];
  programs.gamemode.enable = true;
  boot.plymouth.enable = true;
  boot.loader.timeout = 1;
}

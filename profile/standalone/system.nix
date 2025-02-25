/* Configuration */
{ ... }: {
  imports = [ ../../modules/system/btrfs.nix ];
  programs.gamemode.enable = true; 
  
  boot.plymouth.enable = true;
  boot.loader.timeout = 1;
}

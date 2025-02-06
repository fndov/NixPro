/* 
Edit this Configuration file to define what should be installed on
- your system. Help is available in the configuration.nix(5) man page
- and in the NixOS manual (accessible by running `nixos-help`). 
*/
{ ... }: {
  imports = [ /* Configuration */
    ../../system/compose/vm.nix
    ../../system/driver/kernel.nix
    ../../system/driver/automount.nix
    ../../system/driver/bluetooth.nix
    ../../system/driver/memory.nix
    ../../system/driver/pipewire.nix
    ../../system/driver/usbmuxd.nix
    ../../system/compose/keyring.nix
    ../../system/compose/gamemode.nix
  ];

  boot.plymouth.enable = true;
  boot.loader.timeout = 1;

  system.stateVersion = settings.system.version;
}

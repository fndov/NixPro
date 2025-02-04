/* Edit this Configuration file to define what should be installed on
- your system. Help is available in the configuration.nix(5) man page
- and in the NixOS manual (accessible by running `nixos-help`). */
{ ... }: {
  imports = [ /* Configuration */
    ../../system/software/vm.nix
    ../../system/hardware/kernel.nix
    ../../system/hardware/automount.nix
    ../../system/hardware/bluetooth.nix
    ../../system/hardware/boot.nix
    ../../system/hardware/memory.nix
    ../../system/hardware/network.nix
    ../../system/hardware/pipewire.nix
    ../../system/hardware/usbmuxd.nix
    ../../system/security/extra.nix
    ../../system/security/firewall.nix
    ../../system/security/keyring.nix
    ../../system/security/timezone.nix
    ../../system/software/gamemode.nix
  ];

  # networking.wireless.enable = false;
  networking.networkmanager.enable = true; 

  boot.plymouth.enable = true;
  boot.loader.timeout = 1;

  system.stateVersion = settings.system.version;
}

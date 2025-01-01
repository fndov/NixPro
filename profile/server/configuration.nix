# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).
{ ... }: {
  imports = [
    # Managed ../../system/hardware/hardware.nix
    # Managed ../../system/hardware/amd.nix
    # Managed ../../system/hardware/nvidia.nix
    # ../../system/hardware/bluetooth.nix
    # ../../system/hardware/usbmuxd.nix
    # ../../system/software/vm.nix
    # ../../system/hardware/pipewire.nix
    # ../../system/security/keyring.nix
    # ../../system/security/firewall.nix
    # ../../system/security/printing.nix
    # ../../system/wm/login.nix
    ../../system/hardware/memory.nix
    ../../system/hardware/kernel.nix
    ../../system/hardware/network.nix
    ../../system/hardware/automount.nix
    ../../system/security/timezone.nix
    ../../system/security/account/default.nix
    ../../system/security/sshd.nix
  ];
  # Extra NixOS settings.
  system.stateVersion = "24.11"; # Please read the comment before changing.

  # Boot settings.
  # boot.plymouth.enable = true;
  boot.loader.timeout = 0;

  services.getty.autologinUser = "root";
}

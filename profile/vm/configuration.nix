# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).
{ ... }: {
  imports = [
    # Managed ../../system/hardware/hardware.nix
    # Managed ../../system/hardware/amd.nix
    # Managed ../../system/hardware/nvidia.nix
    # Managed ../../system/hardware/intel.nix
    # ../../system/hardware/usbmuxd.nix # Broken on latest version: Tue Dec 31 02:48:19 PM CST 2024
    # ../../system/hardware/bluetooth.nix
    # ../../system/security/printing.nix
    # ../../system/security/firewall.nix
    # ../../system/hardware/memory.nix
    # ../../system/hardware/kernel.nix
    # ../../system/hardware/pipewire.nix
    # ../../system/hardware/automount.nix
    # ../../system/security/keyring.nix
    # ../../system/software/vm.nix
    # ../../system/wm/login.nix
    ../../system/hardware/network.nix
    ../../system/security/timezone.nix
    ../../system/security/account/default.nix
    ../../system/security/sshd.nix
  ];
  services.getty.autologinUser = "miyu";

  boot.plymouth.enable = true;
  boot.loader.timeout = 0;
  # boot.loader.grub.useOSProber = true;

  system.stateVersion = "24.11"; # Please read the comment before changing.
}

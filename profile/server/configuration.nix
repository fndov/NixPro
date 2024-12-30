{ systemSettings, ... }: {
  imports = [
    # Managed ../../system/hardware/hardware.nix
    # Managed ../../system/hardware/amd.nix
    # Managed ../../system/hardware/nvidia.nix
    # ../../system/hardware/bluetooth.nix
    # ../../system/hardware/usbmuxd.nix
    ../../system/hardware/memory.nix
    ../../system/hardware/kernel.nix
    ../../system/hardware/network.nix
    # ../../system/hardware/pipewire.nix
    ../../system/hardware/automount.nix
    # ../../system/security/keyring.nix
    # ../../system/security/firewall.nix
    # ../../system/security/printing.nix
    ../../system/security/timezone.nix
    ../../system/security/account/default.nix
    ../../system/security/sshd.nix
    # ../../system/software/vm.nix
    # ../../system/wm/login.nix
  ];
  nix.settings.trusted-users = [ "@wheel" ];
  nix.settings.substituters = [ "https://hyprland.cachix.org" ];
  nix.settings.trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  nix.extraOptions = "experimental-features = nix-command flakes";
  system.stateVersion = "24.11"; # Please read the comment before changing.

  # boot.plymouth.enable = true;
  boot.loader.timeout = 0;
  # boot.loader.grub.useOSProber = true;
  boot.loader.systemd-boot.enable = if (systemSettings.bootMode == "uefi") then true else false;
  boot.loader.efi.efiSysMountPoint = systemSettings.bootMountPath; # does nothing if running bios rather than uefi
  boot.loader.efi.canTouchEfiVariables = if (systemSettings.bootMode == "uefi") then true else false;
  boot.loader.grub.enable = if (systemSettings.bootMode == "uefi") then false else true;
  boot.loader.grub.device = systemSettings.grubDevice;
  
  services.getty.autologinUser = "root";
}

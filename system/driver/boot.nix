{ settings, ... }: {
  boot.loader.grub.useOSProber = true;
  boot.loader.systemd-boot.enable = if (settings.system.bootMode == "uefi") then true else false;
  boot.loader.efi.efiSysMountPoint = settings.system.bootMountPath; # does nothing if running bios rather than uefi
  boot.loader.efi.canTouchEfiVariables = if (settings.system.bootMode == "uefi") then true else false;
  boot.loader.grub.enable = if (settings.system.bootMode == "uefi") then false else true;
  boot.loader.grub.device = settings.system.grubDevice;
}
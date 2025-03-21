{ lib, ... }:{
  imports = [
    ../../modules/commands/sh.nix
    ../../modules/commands/cli.nix
    ../../modules/commands/lib.nix
    ../../modules/development/cc.nix
  ];
  systemd.services."serial-getty@ttyS0".enable = lib.mkDefault false;
  systemd.services."serial-getty@hvc0".enable = false;
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@".enable = false;
  boot.kernelParams = [
    "panic=1"
    "boot.panic_on_fail"
    "vga=0x317"
    "nomodeset"
  ];
  # swapDevices = [ { device = "/swapfile"; priority = 2; size = 16*1024; } ];
  systemd.enableEmergencyMode = false;
  boot.loader.grub.splashImage = null;
}

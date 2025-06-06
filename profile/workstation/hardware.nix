{ config, lib, pkgs, modulesPath, ... }: {
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "sr_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.initrd.luks.devices."luks-3d50afbd-8126-4e58-9e9f-eabd40e642e7".device = "/dev/disk/by-uuid/3d50afbd-8126-4e58-9e9f-eabd40e642e7";
  boot.kernelModules = [ "kvm-intel" ];
  boot.kernelParams = [ "resume=/dev/sda6" ];
  boot.extraModulePackages = [ ];

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-uuid/25DD-3446";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };
    "/" = {
      device = "/dev/disk/by-uuid/874f0d63-3841-4fc7-814d-3117faf463e0";
      fsType = "btrfs";
      options = [
        "subvol=@"
        "autodefrag"
        "space_cache=v2"
        "compress=zstd:4"
        "noatime"
        "nodiratime"
        "discard=async"
      ];
    };
  };
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
  };

  swapDevices = [ { device = "/dev/sda6"; priority = 2; } ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}

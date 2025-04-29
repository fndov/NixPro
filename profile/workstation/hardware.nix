{ config, lib, modulesPath, ... }: {
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "sd_mod" "sr_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.initrd.luks.devices."luks-314d8043-ffe1-4a3e-b442-f86857f70765".device = "/dev/disk/by-uuid/314d8043-ffe1-4a3e-b442-f86857f70765";
  boot.kernelModules = [ "kvm-intel" ];
  boot.kernelParams = [ "resume=/dev/sda7" ];
  boot.extraModulePackages = [ ];

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-uuid/A6BD-93E6";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };
    "/" = {
      device = "/dev/disk/by-uuid/7cb4ff42-4c16-4227-be44-91049697abf5";
      fsType = "btrfs";
      options = [
        "subvol=@"
        "autodefrag"
        "space_cache=v2"
        "compress=zstd"
        "noatime"
        "nodiratime"
      ];
    };
  };
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
  };

  swapDevices = [ { device = "/dev/sda7"; priority = 4; } ];

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

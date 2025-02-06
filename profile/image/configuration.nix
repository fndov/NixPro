{ config, lib, pkgs, settings, modulesPath, ... }: {
  imports = [ 
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
    ../../system/driver/pipewire.nix
    ../../system/driver/memory.nix
    ../../system/driver/kernel.nix
  ];
  isoImage = {
    isoName = lib.mkForce (builtins.replaceStrings ["--" "-linux"] ["-" ""] "nixpro-${settings.system.version}-${
      if settings.desktop.enable
      then if settings.desktop.type == "wm" 
           then settings.desktop.wm 
           else settings.desktop.de
      else ""
    }-${settings.system.architecture}.iso");

    squashfsCompression = 
    # "lz4"; # Fast.
    "xz -Xdict-size 100%"; # Small.
    contents = [
      {
        source = lib.cleanSource ../../../../../home/${settings.user.name}/${settings.system.flakePath}; # Impure, but it's fine.
        target = "/home/${settings.user.name}/.nixpro";
        user = settings.user.name;
        group = "users";
        mode = "0700";
      }
    ];
  };

  systemd.services.auto-init = {
      description = "Run custom initialization commands at boot";
      serviceConfig.Type = "oneshot";
      script = ''
        nixos-generate-config
        mkdir -p /home/miyu/.nixpro  
        cp -rp /iso/home/miyu/.nixpro /home/miyu/.nixpro
      '';
      wantedBy = [ "multi-user.target" ];
    };
  }

  boot.initrd = {
    availableKernelModules = [ "sdhci_pci" "nvme" "btrfs" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
    includeDefaultModules = true;
    kernelModules = [ ];
    supportedFilesystems = [
      "ntfs" 
      "exfat" 
      "ext4" 
      "fat32" 
      "btrfs" 
      "vfat" 
      "f2fs"
      "reiserfs"
      "xfs"
      "ntfs"
      "cifs"
      "zfs"
      "auto"
      "squashfs"
      "tmpfs"
      "overlay"
    ];
  };

  services.devmon.enable = true;
  environment.systemPackages = [ pkgs.calamares-nixos ];
  /* Save space. */
  # hardware.enableAllFirmware = lib.mkForce false;
  # hardware.enableRedistributableFirmware = lib.mkForce false;
  # systemd.services.NetworkManager-wait-online.enable = false;
  services.earlyoom = { 
    enable = true;
    enableNotifications = true;
    freeMemThreshold = 10;
    freeMemKillThreshold = 10;
    freeSwapThreshold = 10;
    freeSwapKillThreshold = 10;
  };

  services.getty.autologinUser = lib.mkForce "${settings.user.name}";
  boot.hardwareScan = true;
  system.stateVersion = settings.system.version;
}
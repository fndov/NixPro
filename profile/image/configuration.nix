{ config, lib, pkgs, settings, modulesPath, ... }: {
  imports = [ 
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
    ../../system/hardware/pipewire.nix
    ../../system/hardware/memory.nix
  ];

  isoImage.isoName = lib.mkForce (builtins.replaceStrings ["--" "-linux"] ["-" ""] "nixpro-${settings.system.version}-${
    if settings.desktop.enable
    then if settings.desktop.type == "wm" 
         then settings.desktop.wm 
         else settings.desktop.de
    else ""
  }-${settings.system.architecture}.iso");
  
  isoImage = {
    squashfsCompression = "lz4"; # Fast.
    # "xz -Xdict-size 100%"; # Small.
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

  /* Save space. */
  # hardware.enableAllFirmware = lib.mkForce false;
  # hardware.enableRedistributableFirmware = lib.mkForce false;
  # systemd.services.NetworkManager-wait-online.enable = false;
  services.earlyroom.enable = true;
  services.earlyroom.enableNotifications = true;
  services.earlyroom.freeMemThreshold = 10;
  services.earlyroom.freeMemKillThreshold = 10;
  services.earlyroom.freeSwapThreshold = 10;
  services.earlyroom.freeSwapKillThreshold = 10;
  
  /* Networking. */
  environment.systemPackages = [ pkgs.networkmanager ];
  networking.wireless.enable = lib.mkForce false;
  networking.networkmanager.enable = true;
  services = {
    udev.packages = [ pkgs.networkmanager ];
    dbus.enable = true;
    resolved.enable = true;
  };

  system.stateVersion = settings.system.version;
} /* 

Build the ISO with:

nixim


When in the image:

sudo nixos-generate-config
cp -f /etc/nixos/hardware-configuration.nix ~/.nixpro/system/hardware/hardware.nix

Run software faster with

nice -n -20 <program>

*/

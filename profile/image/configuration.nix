{ config, lib, pkgs, settings, modulesPath, ... }: {
  imports = [ 
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
    ../../system/driver/pipewire.nix
    ../../system/driver/memory.nix
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
  services.earlyoom = { 
    enable = true;
    enableNotifications = true;
    freeMemThreshold = 10;
    freeMemKillThreshold = 10;
    freeSwapThreshold = 10;
    freeSwapKillThreshold = 10;
  };

  system.stateVersion = settings.system.version;
}
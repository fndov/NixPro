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
    "zstd"; /* Fast, size can be twice as much as xz. */
    # "xz -Xdict-size 100%"; /* Small, slow to decompress to decompress. */
    contents = [
      {
        source = lib.cleanSource /home/${settings.user.name}/${settings.system.flakePath}; # Impure, but it's fine.
        target = "/home/${settings.user.name}/.nixpro";
        user = settings.user.name;
        group = "users";
        mode = "0777";
      }
    ];
  };
  systemd.services.auto-init = {
    description = "Run custom initialization commands at boot";
    serviceConfig = {
      Type = "oneshot";
      User = "miyu";
      Group = "users";
      UMask = "0002";
    };
    script = ''
      #! /bin/bash
      set -e  # Exit immediately if a command exits with a non-zero status.
      echo "Running auto-init service..."
  
      mkdir -p /home/miyu/.nixpro
  
      sudo nixos-generate-config
      cp -rp /iso/home/miyu/.nixpro /home/miyu/
      sudo rm -rf /iso/home/miyu/.nixpro
      sudo rm -rf /home/nixos/
      cp -f /etc/nixos/hardware.nix /home/miyu/.nixpro/system/driver/hardware.nix
      chown -R miyu:users /home/miyu/.nixpro # Ensure correct ownership
  
      echo "auto-init service completed."
    '';
    wantedBy = [ "multi-user.target" ];
  };

  environment.systemPackages = with pkgs; [ fontconfig ];
  hardware.graphics.enable = true;
  
  documentation.enable = false;

  services.getty.autologinUser = lib.mkForce "${settings.user.name}";
  boot.hardwareScan = true;
  system.stateVersion = settings.system.version;
}

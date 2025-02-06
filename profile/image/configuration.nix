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
    "lz4"; # Fast.
    # "xz -Xdict-size 100%"; # Small.
    contents = [
      {
        source = lib.cleanSource /home/${settings.user.name}/${settings.system.flakePath}; # Impure, but it's fine.
        target = "/home/${settings.user.name}/.nixpro"; # Fixes that? I added ".."
        user = settings.user.name;
        group = "users";
        mode = "0777";
      }
    ];
  };

  systemd.services.auto-init = {
    description = "Run custom initialization commands at boot";
    serviceConfig.Type = "oneshot";
    script = ''
      nixos-generate-config
      cp -rp /iso/home/miyu/.nixpro /home/miyu/.nixpro
      cp -f /etc/nixos/hardware.nix /home/miyu/.nixpro/system/driver/hardware.nix
    '';
    wantedBy = [ "multi-user.target" ];
  };

  services.devmon.enable = true;
  environment.systemPackages = [ pkgs.calamares-nixos ];
  /* Save space. */
  # hardware.enableAllFirmware = lib.mkForce false;
  # hardware.enableRedistributableFirmware = lib.mkForce false;
  documentation.enable = false;

  services.getty.autologinUser = lib.mkForce "${settings.user.name}";
  boot.hardwareScan = true;
  system.stateVersion = settings.system.version;
}

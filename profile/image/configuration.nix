{ config, lib, pkgs, settings, modulesPath, ... }: {
  imports = [ 
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
    ../../system/driver/pipewire.nix
    ../../system/driver/memory.nix
    ../../system/driver/kernel.nix
    ../../system/driver/usbmuxd.nix
  ];
  isoImage = {
    isoName = lib.mkForce (builtins.replaceStrings ["--" "-linux"] ["-" ""] "nixpro-${settings.system.version}-${
      if settings.desktop.enable
      then if settings.desktop.type == "wm" 
           then settings.desktop.wm 
           else settings.desktop.de
      else ""
    }-${settings.system.architecture}.iso");

    squashfsCompression = "zstd";
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
  systemd.services.NetworkManager-wait-online.enable = false;
  hardware.graphics.enable = true;
  documentation.enable = false;
  services.getty.autologinUser = lib.mkForce "${settings.user.name}";
  boot.hardwareScan = true;
  system.stateVersion = settings.system.version;
}

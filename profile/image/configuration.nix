{ lib, settings, modulesPath, ... }: {
  imports = [
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
    # ../../system/driver/pipewire.nix
    # ../../system/driver/memory.nix
    # ../../system/driver/kernel.nix
  ];
  isoImage = {
    isoName = lib.mkForce (builtins.replaceStrings ["--" "-linux"] ["-" ""] "nixpro-${settings.system.version}-${
      if settings.desktop.enable
        then if settings.desktop.type == "wm"
          then settings.desktop.wm
        else settings.desktop.de
      else ""
    }-${settings.system.architecture}.iso");
    squashfsCompression = "zstd -Xcompression-level 22";
    contents = [
      {
        source = lib.cleanSource /home/${settings.user.name}/${settings.system.flakePath}; # Impure.
        target = "/home/${settings.user.name}/.nixpro";
        user = settings.user.name;
        group = "users";
        mode = "0777";
      }
    ];
  };
  # nix.settings.keep-outputs = false;
  # nix.settings.keep-derivations = false;
  # boot.kernelParams = if settings.system.security == false then [ "page_alloc.shuffle=0" ] else [ ];
  users.users.root.hashedPassword = lib.mkForce null;
  users.users.nixos = { _module = {}; };
  services.openssh.enable = lib.mkForce false;
  # systemd.services.NetworkManager-wait-online.enable = false;
  # hardware.graphics.enable = true;
  services.getty.autologinUser = lib.mkForce "${settings.user.name}";
  services.getty.helpLine = lib.mkForce "";
}

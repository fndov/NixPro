{ lib, settings, modulesPath, ... }: {
  imports = [
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
    ../../modules/commands/sh.nix
    ../../modules/commands/lib.nix
  ];

  isoImage = {
    isoName = lib.mkForce (builtins.replaceStrings ["--" "-linux"] ["-" ""] "nixpro-${settings.system.version}-${
      if settings.desktop.type != null then settings.desktop.type else ""
    }-${settings.system.architecture}.iso");
    squashfsCompression = "zstd";
    contents = [ {
      source = lib.cleanSource /home/${settings.account.name}/${settings.system.flakePath}; # Impure warning.
      target = "/home/${settings.account.name}/${settings.system.flakePath}";
      user = settings.account.name;
      group = "users";
      mode = "0777";
    } ];
  };

  nix.settings.keep-outputs = false;
  nix.settings.keep-derivations = false;
  users.users.nixos = { _module = {}; };
  services.openssh.enable = lib.mkForce false;
  hardware.graphics.enable = true;
  hardware.graphics.enable32 = false;
  hardware.enableAllFirmware = true;
  hardware.enableRedistributableFirmware = true;
  boot.loader.timeout = lib.mkForce 3;
}

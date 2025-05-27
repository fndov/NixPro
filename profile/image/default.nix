{ lib, pkgs, settings, modulesPath, ... }: {
  imports = [
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
    ../../modules/commands/sh.nix
    ../../modules/commands/lib.nix
  ];
  boot.kernelPackages = pkgs.linuxPackages_xanmod;
  boot.kernelPatches = [ ];
  boot.kernelParams = [
    "splash"
    "quiet"
    "rd.systemd.show_status=false"
    "udev.log_level=0"
    "rd.udev.log_level=0"
    "udev.log_priority=0"
    "fastboot"
    "mitigations=off"
    "noibrs"
    "noibpb"
    "nopti"
    "nospectre_v1"
    "nospectre_v2"
    "l1tf=off"
    "nospec_store_bypass_disable"
    "no_stf_barrier"
    "mds=off"
    "tsx=on"
    "tsx_async_abort=off"
    "nowatchdog"
    "panic=1"
    "boot.panic_on_fail"
    "transparent_hugepage=always"
    "init_on_alloc=0"
    "init_on_free=0"
    "idle=nomwait"
    "ascpi_osi=Linux"
    "preempt=full"
    "uinput"
  ];
  boot.blacklistedKernelModules = [
    "nouveau"
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
  documentation.man.enable = lib.mkForce false;
  nix.settings.keep-outputs = false;
  nix.settings.keep-derivations = false;
  users.users.nixos = { _module = {}; };
  services.openssh.enable = lib.mkForce false;
  hardware.graphics.enable = true;
  # hardware.enableAllFirmware = true;
  # hardware.enableRedistributableFirmware = true;
  boot.loader.timeout = lib.mkForce 3;
}

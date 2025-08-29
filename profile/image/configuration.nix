{ lib, pkgs, ... }: {
  imports = [
    # ../../modules/apps/collection.nix
    ../../modules/apps/compact.nix
    ../../modules/apps/spotify.nix
    # ../../modules/apps/virtual-machine.nix
    ../../modules/apps/flatpak.nix
    # ../../modules/development/nix.nix
    ../../modules/commands/base.nix
    ../../modules/commands/shell.nix
    ../../modules/commands/library.nix
    ../../modules/commands/extra.nix
    # ../../modules/development/py.nix
    # ../../modules/apps/steam.nix
    # ../../modules/development/rs.nix
    # ../../modules/development/cc.nix
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

  nixpkgs.config.allowUnfree = true;
  # users.groups.nixos = lib.mkForce {};
  documentation.man.enable = lib.mkForce false;
  nix.settings.keep-outputs = false;
  nix.settings.keep-derivations = false;
  # users.users.nixos = { _module = {}; };
  services.openssh.enable = lib.mkForce false;
  # hardware.enableAllFirmware = true;
  # hardware.enableRedistributableFirmware = true;
  boot.loader.timeout = lib.mkForce 3;
}

{ lib, pkgs, ... }: {
  imports = [
    ../../modules/apps/compact.nix
    ../../modules/apps/spotify.nix
    ../../modules/apps/flatpak.nix
    ../../modules/commands/base.nix
    ../../modules/commands/shell.nix
    ../../modules/commands/library.nix
    ../../modules/commands/extra.nix
    # ../../modules/apps/collection.nix
    # ../../modules/apps/virtual-machine.nix
    # ../../modules/development/nix.nix
    # ../../modules/development/py.nix
    # ../../modules/apps/steam.nix
    # ../../modules/development/rs.nix
    # ../../modules/development/cc.nix
  ];
  nixpkgs.config.allowUnfree = true;
  documentation.man.enable = lib.mkForce false;
  nix.settings.keep-outputs = false;
  nix.settings.keep-derivations = false;
  services.openssh.enable = lib.mkForce false;
  boot.loader.timeout = lib.mkForce 3;
  # users.groups.nixos = lib.mkForce {};
  # users.users.nixos = { _module = {}; };
  # hardware.enableAllFirmware = true;
  # hardware.enableRedistributableFirmware = true;

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
}

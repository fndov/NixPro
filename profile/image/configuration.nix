{ lib, pkgs, ... }: {
  imports = [
    ../../modules/apps/portable.nix
    ../../modules/apps/spotify.nix
    ../../modules/apps/flatpak.nix
    ../../modules/commands/base.nix
    ../../modules/commands/shell.nix
    # ../../modules/commands/extra.nix
    ../../modules/commands/library.nix
    # ../../modules/development/nix.nix
    # ../../modules/development/rs.nix
    # ../../modules/apps/virtualize.nix
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
    "mitigations=off"
    "nospectre_v1"
    "nospectre_v2"
    "nospec_store_bypass_disable"
    "no_stf_barrier"
    "nowatchdog"
    "panic=1"
    "boot.panic_on_fail"
    "init_on_alloc=0"
    "init_on_free=0"
  ];
  boot.blacklistedKernelModules = [
    "nouveau"
  ];
  # users.groups.nixos = lib.mkForce {};
  documentation.man.enable = lib.mkForce false;
  nix.settings.keep-outputs = false;
  nix.settings.keep-derivations = false;
  # users.users.nixos = { _module = {}; };
  services.openssh.enable = lib.mkForce false;
  hardware.graphics.enable = true;
  hardware.enableAllFirmware = true;
  hardware.enableRedistributableFirmware = true;
  boot.loader.timeout = lib.mkForce 3;
}

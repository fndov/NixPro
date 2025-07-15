{ lib, pkgs, ... }: {
  imports = [
    # ../../modules/apps/compact.nix
    # ../../modules/apps/spotify.nix
    # ../../modules/apps/flatpak.nix
    # ../../modules/commands/base.nix
    # ../../modules/commands/shell.nix
    # ../../modules/commands/extra.nix
    # ../../modules/commands/library.nix
    # ../../modules/development/nix.nix
    # ../../modules/development/rs.nix
    # ../../modules/apps/virtualize.nix
  ];
  # boot.kernelPackages = pkgs.linuxPackages_xanmod;
  boot.kernelPatches = [ /*
    {patch = ../../kernel-patches/tkg-6.14/0001-bore.patch;}
    {patch = ../../kernel-patches/tkg-6.14/0009-glitched-bmq.patch;}
    {patch = ../../kernel-patches/tkg-6.14/0012-misc-additions.patch;}
    {patch = ../../kernel-patches/tkg-6.14/0013-optimize_harder_O3.patch;}
    {patch = ../../kernel-patches/tkg-6.14/0014-OpenRGB.patch;} */
   ];
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
  hardware.graphics.enable = true;
  # hardware.enableAllFirmware = true;
  # hardware.enableRedistributableFirmware = true;
  boot.loader.timeout = lib.mkForce 3;
}

/* NixPro-ISO Configuration
- All modules must fit within available RAM
- Avoid heavy modules like vm.nix
- Keep system packages minimal
- Consider compression settings carefully */
{ config, lib, pkgs, settings, modulesPath, ... }: {
  imports = [ /* Configuration */
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix") /*
    ../../system/hardware/bluetooth.nix
    ../../system/security/extra.nix
    ../../system/security/firewall.nix
    ../../system/software/vm.nix
    ../../system/hardware/boot.nix
    ../../system/security/timezone.nix
    ../../system/security/keyring.nix */
    ../../system/hardware/automount.nix
    ../../system/hardware/usbmuxd.nix
    ../../system/hardware/pipewire.nix
    ../../system/hardware/memory.nix
    ../../system/hardware/kernel.nix
  ];
  isoImage.isoName = lib.mkForce "NixPro-${settings.system.version}-${
    if settings.desktop.type == "wm" 
    then settings.desktop.wm 
    else settings.desktop.de
  }-${settings.system.architecture}.iso";
  
  isoImage.squashfsCompression = "lz4"; # Fast.
  # isoImage.squashfsCompression = "xz -Xdict-size 100%"; # Small. 
  
  # isoImage.makeEfiBootable = true;

  # Save space.
  hardware.enableAllFirmware = lib.mkForce false;
  hardware.enableRedistributableFirmware = lib.mkForce false;

  networking.wireless.enable = false;
  networking.networkmanager.enable = true; 
  environment.systemPackages = with pkgs; [
    networkmanager
  ];

  services.earlyoom.enable = true;
  system.stateVersion = settings.system.version;
} /* 

Build the ISO with:

git init
git add flake.nix OR git add .
nix build .#nixosConfigurations.miyu.config.system.build.isoImage
ls result/iso/

*/
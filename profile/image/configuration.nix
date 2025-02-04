/* NixPro-ISO Configuration
- All modules must fit within available RAM
- Avoid heavy modules like vm.nix
- Keep system packages minimal
- Consider compression settings carefully */
{ config, pkgs, settings, modulesPath, ... }: {
  imports = [ /* Configuration */
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix") /*
    ../../system/hardware/bluetooth.nix
    ../../system/security/extra.nix
    ../../system/security/firewall.nix
    ../../system/software/vm.nix
    ../../system/hardware/boot.nix
    ../../system/security/keyring.nix */
    ../../system/security/timezone.nix
    ../../system/hardware/automount.nix
    ../../system/hardware/usbmuxd.nix
    ../../system/hardware/pipewire.nix
    ../../system/hardware/memory.nix
    ../../system/hardware/kernel.nix
    ../../system/wm/login.nix
  ];
  isoImage.isoName = "NixPro-${settings.version}-${
    if settings.desktop.type == "wm" 
    then settings.desktop.wm 
    else settings.desktop.de
  }-${settings.architecture}.iso";
  
  isoImage.squashfsCompression = "lz4"; # Fast.
  # isoImage.squashfsCompression = "xz -Xdict-size 100%"; # Small. 
  
  networking.wireless.enable = true;
  networking.networkmanager.enable = true; 
  
  services.earlyoom.enable = true;
  system.stateVersion = settings.system.version;
} /* 

Build the ISO with:

git init
git add flake.nix OR git add .
nix build .#nixosConfigurations.miyu.config.system.build.isoImage
ls result/iso/

*/
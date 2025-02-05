/* NixPro-Image Configuration
- All modules must fit within available RAM
- Avoid heavy modules like vm.nix
- Keep system packages minimal
- Consider compression settings carefully */
{ config, lib, pkgs, settings, modulesPath, ... }: {
  imports = [ /* Configuration */
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
    ../../system/hardware/automount.nix
    ../../system/hardware/usbmuxd.nix
    ../../system/hardware/pipewire.nix
    ../../system/hardware/memory.nix
    ../../system/hardware/kernel.nix
  ];
  isoImage.isoName = lib.mkForce (builtins.replaceStrings ["--" "-linux"] ["-" ""] "NixPro-${settings.system.version}-${
    if settings.desktop.enable
    then if settings.desktop.type == "wm" 
         then settings.desktop.wm 
         else settings.desktop.de
    else ""
  }-${settings.system.architecture}.iso");
  
  isoImage = {
    squashfsCompression = "lz4"; # Fast.
    contents = [
      {
        source = lib.cleanSource ../../.;  # From profile/image/configuration.nix
        target = "/home/${settings.user.name}/.nixpro";
        # user = settings.user.name;
        # group = "users";
        # mode = "0700";
      }
    ];
  };
  # Save space.
  hardware.enableAllFirmware = lib.mkForce false;
  hardware.enableRedistributableFirmware = lib.mkForce false;
  systemd.services.NetworkManager-wait-online.enable = false;
  services.earlyoom.enable = true;
  
  # Networking.
  environment.systemPackages = [ pkgs.networkmanager ];
  networking.wireless.enable = lib.mkForce false;
  networking.networkmanager.enable = true;
  services = {
    udev.packages = [ pkgs.networkmanager ];
    dbus.enable = true;
    resolved.enable = true;
  };

  system.stateVersion = settings.system.version;
} /* 

Build the ISO with:

git init
git add flake.nix OR git add .
nix build .#nixosConfigurations.miyu.config.system.build.isoImage
ls result/iso/

*/
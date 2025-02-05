{ config, lib, pkgs, settings, modulesPath, ... }: {
  imports = [ 
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
    ../../system/hardware/automount.nix
    ../../system/hardware/usbmuxd.nix
    ../../system/hardware/pipewire.nix
    ../../system/hardware/memory.nix
    ../../system/hardware/kernel.nix
  ];

  isoImage.isoName = lib.mkForce (builtins.replaceStrings ["--" "-linux"] ["-" ""] "nixpro-${settings.system.version}-${
    if settings.desktop.enable
    then if settings.desktop.type == "wm" 
         then settings.desktop.wm 
         else settings.desktop.de
    else ""
  }-${settings.system.architecture}.iso");
  
  isoImage = {
    squashfsCompression = "lz4"; # Fast.
    # "xz -Xdict-size 100%"; # Small.
    
  contents = [
    {
    source = lib.cleanSource /home/miyu/.nixpro;
    target = "/home/${settings.user.name}/.nixpro";
    user = settings.user.name;
    group = "users";
    mode = "0700";
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


When in the image

sudo nixos-generate-config
cp -f /etc/nixos/hardware-configuration.nix ~/.nixpro/system/hardware/hardware.nix

Run software faster with

nice -n -20 <program>

*/

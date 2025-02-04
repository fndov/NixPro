{ lib, pkgs, settings, ... }: let
  isMicrosoftFish = (settings.profile == "microsoft") && (settings.user.shell == "fish"); 
in {
  users.users.root = 
    if settings.profile == "image" then {
      initialPassword = "password";
      initialHashedPassword = lib.mkForce null;
      hashedPassword = null;
      password = null;
      hashedPasswordFile = null;
    } else {
      initialPassword = "password";
    };

  users.users.${settings.user.name} = {
    isNormalUser = true;
    description = settings.user.name;
    extraGroups = [ "networkmanager" "wheel" "qemu-libvirtd" "libvirtd" "kvm" "docker" ];
    uid = 1000;
    shell = lib.mkIf isMicrosoftFish pkgs.fish;
    initialPassword = "password";
  };

  programs.fish.enable = lib.mkIf isMicrosoftFish true;
  security.sudo.wheelNeedsPassword = false; 
}


{ userSettings, ... }: {
  security.sudo.wheelNeedsPassword = false;
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.username;
    extraGroups = [ "networkmanager" "wheel" "qemu-libvirtd" "libvirtd" "kvm" "docker" ];
    uid = 1000;
  };
}

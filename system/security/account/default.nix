{ userSettings, pkgs, ... }: {
  # Set name in flake.nix
  security.sudo.wheelNeedsPassword = false;
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.username;
    extraGroups = [ "networkmanager" "wheel" "qemu-libvirtd" "libvirtd" "kvm" "docker" ];
    uid = 1000;
    # shell = pkgs.${userSettings.shell};
    # ^ Enabled in user/software/commands/sh.nix
    # ignoreShellProgramCheck = true;
  };
}
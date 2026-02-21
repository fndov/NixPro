{ pkgs, inputs, ... }: let
  unstable = import inputs.nixpkgs-unstable { system = pkgs.stdenv.hostPlatform.system; };
in {
  environment.systemPackages = with unstable; [
    virt-manager
    swtpm # Can't emulate tmp 2.0 without it.
    /*
      gnome-boxes
      distrobox
      swtpm
      OVMF
      qemu
      uefi-run
      lxc
      dosfstools
      kubectl
      docker
      docker-compose
      lazydocker
    */
  ];
  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  # virtualisation.podman.enable = true;
  # virtualisation.podman.dockerCompat = true;

  # virtualisation.docker.enable = true;
  # virtualisation.docker.enableOnBoot = true;
  # virtualisation.docker.autoPrune.enable = true;
  # users.users.settings.account.name.extraGroups = [ "docker" ];
}

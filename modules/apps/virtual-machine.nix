{ unstable, ... }: {
  environment.systemPackages = with unstable; [
    virt-manager
    distrobox
    /*
      swtpm # Can't emulate tmp 2.0 without it.
      gnome-boxes
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
  # Virt-manager
  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  # Distrobox
  virtualisation.podman.enable = true;
  virtualisation.podman.dockerCompat = true;

  # virtualisation.docker.enable = true;
  # virtualisation.docker.enableOnBoot = true;
  # virtualisation.docker.autoPrune.enable = true;
  # users.users.settings.account.name.extraGroups = [ "docker" ];
}

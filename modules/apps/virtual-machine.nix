{ pkgs, inputs, ... }: let
  unstable = import inputs.nixpkgs-unstable { inherit (pkgs) system; };
in {
  environment.systemPackages = with unstable; [
    virt-manager
    /*
      gnome-boxes
      distrobox
      swtpm
      OVMF
      unstable.qemu
      uefi-run
      lxc
      swtpm
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

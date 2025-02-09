{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    virt-manager
    distrobox
    qemu
    uefi-run
    lxc
    swtpm
    dosfstools
    # kubectl
  ];
  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.podman.enable = true;
  virtualisation.podman.dockerCompat = true;
}

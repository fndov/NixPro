{ config, pkgs, ... }: {
  environment.systemPackages = [ pkgs.virt-manager pkgs.distrobox ];
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "miyu" ];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.podman.enable = true;
  virtualisation.podman.dockerCompat = true;
}

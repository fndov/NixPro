{ pkgs, inputs, ... }: let
  unstable = import inputs.nixpkgs-unstable { inherit (pkgs) system; };
in {
  environment.systemPackages = with pkgs; [
    unstable.virt-manager
    # unstable.distrobox
    # unstable.qemu
    # uefi-run
    # lxc
    # swtpm
    # dosfstools
    # kubectl
  ];
  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.podman.enable = true;
  virtualisation.podman.dockerCompat = true;
}

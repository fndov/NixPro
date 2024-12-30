{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    libvirt
    qemu
    uefi-run
    lxc
    swtpm
    # Filesystems
    dosfstools
  ];

  home.file.".config/libvirt/qemu.conf".text = ''
nvram = ["/run/libvirt/nix-ovmf/OVMF_CODE.fd:/run/libvirt/nix-ovmf/OVMF_VARS.fd"]
  '';
}

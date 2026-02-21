{ pkgs, ... }: {
  services.flatpak.enable = true;
  environment.systemPackages = [
    pkgs.gnome-software
    # pkgs.warehouse
  ];
}

{ pkgs, ... }: {
  services.flatpak.enable = true;
  environment.systemPackages = with pkgs; [
    flatpak
    warehouse
  ];
}

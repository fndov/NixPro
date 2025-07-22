{ pkgs, ... }: {
  services.flatpak.enable = true;
  environment.systemPackages = with pkgs; [
    warehouse
  ];
}

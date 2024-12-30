{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.libsecret ];
  security.pam.services.ly.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;
}

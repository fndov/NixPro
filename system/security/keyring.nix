{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.libsecret ];
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.ly.enableGnomeKeyring = true;
}

{ lib, pkgs, ... }: {
  services.xserver.enable = true;
  services.xserver.desktopManager.cinnamon.enable = true;
  services.displayManager.ly.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  services.avahi.openFirewall = true;
  environment.systemPackages = [ pkgs.cups-filters ];
  hardware.bluetooth.enable = true;
  boot.plymouth.enable = true;
  boot.loader.timeout = lib.mkForce 1;

}

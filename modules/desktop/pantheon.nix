{ lib, pkgs, ... }: {
  services.xserver.enable = true;
  services.xserver.desktopManager.pantheon.enable = true;

  security.rtkit.enable = true;
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true;
  services.pipewire.pulse.enable = true;
  services.pipewire.jack.enable = true;

  services.printing.enable = true;
  environment.systemPackages = [ pkgs.cups-filters ];

  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  services.avahi.openFirewall = true;

  hardware.bluetooth.enable = false;

  boot.plymouth.enable = true;
  boot.loader.timeout = lib.mkForce 1;
}

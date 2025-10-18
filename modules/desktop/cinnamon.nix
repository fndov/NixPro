{ lib, ... }: {
  # Desktop
  services.xserver.enable = true;
  services.xserver.desktopManager.cinnamon.enable = true;
  services.displayManager.ly.enable = true;

  # Audio
  security.rtkit.enable = true;
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true;
  services.pipewire.pulse.enable = true;
  services.pipewire.jack.enable = true;

  services.printing.enable = true;

  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  services.avahi.openFirewall = true;

  hardware.bluetooth.enable = true;

  # Boot screen
  boot.plymouth.enable = true;
  boot.loader.timeout = lib.mkForce 1;
}

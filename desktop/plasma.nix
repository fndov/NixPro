{ lib, pkgs, settings, ... }: {
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
	services.displayManager.defaultSession = "plasma";
	services.displayManager.autoLogin.enable = true;
	services.displayManager.autoLogin.user = settings.account.name;
  security.rtkit.enable = true;
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true;
  services.pipewire.pulse.enable = true;
  services.pipewire.jack.enable = true;
  boot.plymouth.enable = true;
  boot.loader.timeout = lib.mkForce 1;
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  services.avahi.openFirewall = true;
  environment.systemPackages = [ pkgs.cups-filters ];
}

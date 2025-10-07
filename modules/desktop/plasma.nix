{ pkgs, settings, ... }: {
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;

	services.displayManager.autoLogin.enable = true;
	services.displayManager.defaultSession = "plasma";
	services.displayManager.autoLogin.user = settings.account.name;

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

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  boot.plymouth.enable = true;
  boot.loader.timeout = 1; /*

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    kdepim-runtime
    konsole
    oxygen
    kate
    elisa
    gwenview
    khelpcenter
    plasma-workspace-wallpapers
    breeze
    breeze-icons
    breeze-gtk
  ]; */
}

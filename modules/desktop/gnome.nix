{ lib, pkgs, settings, ... }: {
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  security.rtkit.enable = true;
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true;
  services.pipewire.pulse.enable = true;
  services.pipewire.jack.enable = true;

  services.printing.enable = true;

  services.usbmuxd.enable = true;
  services.usbmuxd.package = pkgs.usbmuxd2;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.getty.autologinUser = lib.mkForce "${settings.account.name}";
  services.getty.helpLine = lib.mkForce "";

  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  services.avahi.openFirewall = true;

  environment.systemPackages = with pkgs; [
    gnomeExtensions.blur-my-shell
    cups-filters
    gnome-extension-manager
    gnome-browser-connector
  ];

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  home-manager.users.${settings.account.name} = {
    xdg.enable = true;
    xdg.mime.enable = true;
    xdg.mimeApps.enable = true;
    xdg.userDirs = {
      enable = true;
      createDirectories = true;
      music = "/home/${settings.account.name}/Media/Music";
      videos = "/home/${settings.account.name}/Media/Videos";
      pictures = "/home/${settings.account.name}/Media/Pictures";
      templates = "/home/${settings.account.name}/Templates";
      download = "/home/${settings.account.name}/Downloads";
      documents = "/home/${settings.account.name}/Documents";
      desktop = null;
      publicShare = null;
      extraConfig.XDG_ARCHIVE_DIR = "/home/${settings.account.name}/Archive";
      extraConfig.XDG_VM_DIR = "/home/${settings.account.name}/Machines";
      extraConfig.XDG_ORG_DIR = "/home/${settings.account.name}/Org";
      extraConfig.XDG_PODCAST_DIR = "/home/${settings.account.name}/Media/Podcasts";
      extraConfig.XDG_BOOK_DIR = "/home/${settings.account.name}/Media/Books";
    };
  };
  boot.plymouth.enable = true;
  boot.loader.timeout = lib.mkForce 1;
}

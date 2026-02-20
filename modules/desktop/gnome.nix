{ lib, pkgs, settings, ... }:
{
  # Desktop
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Audio
  security.rtkit.enable = true;
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true;
  services.pipewire.pulse.enable = true;
  services.pipewire.jack.enable = true;

  # Other
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

  programs.seahorse.enable = true;
  services.gnome.gnome-keyring.enable = true;

  environment.systemPackages = with pkgs; [
    gnomeExtensions.clipboard-history
    gnomeExtensions.coverflow-alt-tab
    gnomeExtensions.rounded-window-corners-reborn
    gnomeExtensions.blur-my-shell
    gnome-extension-manager
    gnome-browser-connector
    gnome-control-center
    gnome-tweaks # Use it to autostart things like the browser.
    cups-filters
    noto-fonts-cjk-sans
  ];

  environment.gnome.excludePackages = with pkgs; [
    gnome-console
    geary
    gnome-tour
    epiphany
    xterm
  ];

  qt.enable = true;
  qt.platformTheme = "gnome";
  qt.style = "adwaita-dark";

  # Directory stuff
  home-manager.users.${settings.account.name} = {
    xdg.enable = true;
    xdg.mime.enable = true;
    xdg.mimeApps.enable = true;
    xdg.userDirs = {
      enable = true;
      createDirectories = true;
      publicShare = null;
      desktop = "/home/${settings.account.name}/Documents/Desktop";
      documents = "/home/${settings.account.name}/Documents";
      download = "/home/${settings.account.name}/Downloads";
      templates = "/home/${settings.account.name}/Documents/Templates";
      music = "/home/${settings.account.name}/Media/Music";
      pictures = "/home/${settings.account.name}/Media/Pictures";
      extraConfig.XDG_WALLPAPER_DIR = "/home/${settings.account.name}/Media/Pictures/Wallpapers";
      extraConfig.XDG_ARTWORK_DIR = "/home/${settings.account.name}/Media/Pictures/Artwork";
      extraConfig.XDG_GALLERY_DIR = "/home/${settings.account.name}/Media/Pictures/Gallery";
      extraConfig.XDG_MEMES_DIR = "/home/${settings.account.name}/Media/Pictures/Memes";
      extraConfig.XDG_PRIVATE_PICTURES_DIR = "/home/${settings.account.name}/Media/Pictures/Private";
      videos = "/home/${settings.account.name}/Media/Videos";
      extraConfig.XDG_BOOK_DIR = "/home/${settings.account.name}/Media/Books";
      extraConfig.XDG_PODCAST_DIR = "/home/${settings.account.name}/Media/Podcasts";
      extraConfig.XDG_ARCHIVE_DIR = "/home/${settings.account.name}/Archive";
      extraConfig.XDG_APPIMAGES_DIR = "/home/${settings.account.name}/Archive/Appimages";
      extraConfig.XDG_DEVELOPMENT = "/home/${settings.account.name}/Development";
      extraConfig.XDG_VM_DIR = "/home/${settings.account.name}/Machines";
      extraConfig.XDG_VM_STORAGE_DIR = "/home/${settings.account.name}/Machines/Storage";
      extraConfig.XDG_VM_ISO_DIR = "/home/${settings.account.name}/Machines/ISO";
      extraConfig.XDG_ORG_DIR = "/home/${settings.account.name}/Org";
      extraConfig.XDG_INC_DIR = "/home/${settings.account.name}/Inc";
      extraConfig.XDG_EDU_DIR = "/home/${settings.account.name}/Edu";
    };
  };
  # Boot screen
  boot.plymouth.enable = true;
  boot.loader.timeout = lib.mkForce 1;
}

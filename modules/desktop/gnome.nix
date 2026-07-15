{ lib, pkgs, settings, ... }: {
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

  programs.xwayland.enable = true;

  environment.systemPackages = with pkgs; [
    gnome-extension-manager
    gnomeExtensions.clipboard-history
    gnomeExtensions.rounded-window-corners-reborn
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash-to-panel
    gnome-browser-connector
    gnome-control-center
    gnome-tweaks # Use it to autostart things like the browser.
    cups-filters
    noto-fonts-cjk-sans
    file-roller
    gnome.gvfs
    gvfs
  ];

  environment.gnome.excludePackages = with pkgs; [
    gnome-console
    geary
    gnome-tour
    epiphany
    xterm
  ];

  qt.enable = true;
  # qt.platformTheme = "gnome";
  # qt.style = "adwaita-dark";


  # Directory stuff
  home-manager.users.${settings.account.name} = {
    # Keeping legacy behaviour
    xdg.userDirs.setSessionVariables = true;

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
      extraConfig.WALLPAPER = "/home/${settings.account.name}/Media/Pictures/Wallpapers";
      extraConfig.ARTWORK = "/home/${settings.account.name}/Media/Pictures/Artwork";
      extraConfig.GALLERY = "/home/${settings.account.name}/Media/Pictures/Gallery";
      extraConfig.MEMES = "/home/${settings.account.name}/Media/Pictures/Memes";
      extraConfig.PRIVATE_PICTURES = "/home/${settings.account.name}/Media/Pictures/Private";
      videos = "/home/${settings.account.name}/Media/Videos";
      extraConfig.BOOK = "/home/${settings.account.name}/Media/Books";
      extraConfig.PODCAST = "/home/${settings.account.name}/Media/Podcasts";
      extraConfig.ARCHIVE = "/home/${settings.account.name}/Archive";
      extraConfig.APPIMAGES = "/home/${settings.account.name}/Archive/Appimages";
      extraConfig.DEVELOP = "/home/${settings.account.name}/Development";
      extraConfig.VM = "/home/${settings.account.name}/Machines";
      extraConfig.VM_STORAGE = "/home/${settings.account.name}/Machines/Storage";
      extraConfig.VM_ISO = "/home/${settings.account.name}/Machines/ISO";
      extraConfig.ORG = "/home/${settings.account.name}/Org";
      extraConfig.INC = "/home/${settings.account.name}/Inc";
      extraConfig.EDU = "/home/${settings.account.name}/Edu";
    };
  };
  # Boot screen
  boot.plymouth.enable = true;
  boot.loader.timeout = lib.mkForce 1;
}

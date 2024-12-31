{ userSettings, ... }: {
  # You should delete ~/.config/* because HM intends to manage it.
  imports = [
    ../../user/wm/hyprland/hyprland.nix # Window manager.
    (../.. + "/user/software/apps/terminal"+("/"+userSettings.terminal)+".nix") # Terminal.
    ../../user/software/commands/sh.nix # Shell.
    ../../user/software/commands/cli.nix # Command line interface.
    ../../user/software/commands/git.nix # Git settings.
    ../../user/software/apps/browser/firefox.nix # Browser.
    (../.. + "/user/software/apps/browser"+("/"+userSettings.browser)+".nix") # Terminal.
    ../../user/software/apps/collection.nix # Collection of apps.
    ../../user/software/development/android.nix
    ../../user/software/development/cc.nix
    ../../user/software/development/gd.nix
    ../../user/software/development/hs.nix
    ../../user/software/development/rs.nix
    ../../user/software/development/c.nix
    ../../user/software/development/py-pkgs.nix
    # ../../user/software/development/go.nix
    # ../../user/software/development/zig.nix
  ];
  programs.home-manager.enable = true;
  home.stateVersion = "24.11"; # Please read the comment before changing.

  xdg.enable = true;
  xdg.mime.enable = true;
  xdg.mimeApps.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    music = "/home/${userSettings.username}/Media/Music";
    videos = "/home/${userSettings.username}/Media/Videos";
    pictures = "/home/${userSettings.username}/Media/Pictures";
    templates = "/home/${userSettings.username}/Templates";
    download = "/home/${userSettings.username}/Downloads";
    documents = "/home/${userSettings.username}/Documents";
    desktop = null;
    publicShare = null;
    extraConfig = {
      XDG_ARCHIVE_DIR = "/home/${userSettings.username}/Archive";
      XDG_VM_DIR = "/home/${userSettings.username}/Machines";
      XDG_ORG_DIR = "/home/${userSettings.username}/Org";
      XDG_PODCAST_DIR = "/home/${userSettings.username}/Media/Podcasts";
      XDG_BOOK_DIR = "/home/${userSettings.username}/Media/Books";
    };
  };
  home.sessionVariables = {
    EDITOR = userSettings.editor;
    TERM = userSettings.terminal;
    BROWSER = userSettings.browser;
  };
}

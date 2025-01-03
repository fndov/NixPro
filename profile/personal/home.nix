{ userSettings, ... }: {
  imports = [
    ../../user/software/commands/sh.nix           # Shell.
    ../../user/software/commands/cli.nix          # utils.
    ../../user/software/commands/extra.nix        # Non-essential utils.
    ../../user/wm/hyprland/settings/hyprland.nix  # Window manager.
    (../.. + "/user/software/apps/terminal"+("/"+userSettings.terminal)+".nix") # Terminal.
    ../../user/software/apps/collection.nix       # Collection of apps.
    ../../user/software/apps/extra.nix            # Collection non-essential apps.
    (../.. + "/user/software/apps/browser"+("/"+userSettings.browser)+".nix") # Browser.
    ../../user/software/development/android.nix   # Android development.
    ../../user/software/development/cc.nix        # C/C++ development.
    ../../user/software/development/gd.nix        # Game development.
    ../../user/software/development/hs.nix        # Haskell development.
    ../../user/software/development/rs.nix        # Rust development.
    ../../user/software/development/c.nix         # C development.
    ../../user/software/development/py-pkgs.nix   # Python packages.
    ../../user/software/development/go.nix        # Go development.
    ../../user/software/development/zig.nix       # Zig development.
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

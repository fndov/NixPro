{ settings, ... }: {
  imports = [
    ../../user/software/commands/sh.nix           # Shell.
    ../../user/software/commands/cli.nix          # utils.
    ../../user/software/commands/lib.nix          # NixPro Library.
    ../../user/software/commands/extra.nix        # Non-essential utils.
    ../../user/wm/hyprland/settings/hyprland.nix  # Window manager.
    (../.. + "/user/software/apps/terminal"+("/"+settings.user.terminal)+".nix") # Terminal.
    ../../user/software/apps/collection.nix         # Collection of apps.
    # ../../user/software/apps/extra.nix            # Collection non-essential apps.
    (../.. + "/user/software/apps/browser"+("/"+settings.user.browser)+".nix") # Browser.
    # ../../user/software/apps/spotify.nix          # Spotify for linux.
    # ../../user/software/development/android.nix   # Android development.
    # ../../user/software/development/c.nix         # C development.
    # ../../user/software/development/cc.nix        # C/C++ development.
    # ../../user/software/development/gd.nix        # Game development.
    # ../../user/software/development/hs.nix        # Haskell development.
    # ../../user/software/development/rs.nix        # Rust development.
    # ../../user/software/development/py-pkgs.nix   # Python packages.
    # ../../user/software/development/go.nix        # Go development.
    # ../../user/software/development/zig.nix       # Zig development.
  ];
  # VM Specific.
  wayland.windowManager.hyprland.settings = { monitor = "Virtual-1, 1920x1080, 0x0, 1"; };

  # Default.
  programs.home-manager.enable = true;
  home.stateVersion = settings.system.version;

  xdg.enable = true;
  xdg.mime.enable = true;
  xdg.mimeApps.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    music = "/home/${settings.user.name}/Media/Music";
    videos = "/home/${settings.user.name}/Media/Videos";
    pictures = "/home/${settings.user.name}/Media/Pictures";
    templates = "/home/${settings.user.name}/Templates";
    download = "/home/${settings.user.name}/Downloads";
    documents = "/home/${settings.user.name}/Documents";
    desktop = null;
    publicShare = null;
    extraConfig = {
      XDG_ARCHIVE_DIR = "/home/${settings.user.name}/Archive";
      XDG_VM_DIR = "/home/${settings.user.name}/Machines";
      XDG_ORG_DIR = "/home/${settings.user.name}/Org";
      XDG_PODCAST_DIR = "/home/${settings.user.name}/Media/Podcasts";
      XDG_BOOK_DIR = "/home/${settings.user.name}/Media/Books";
    };
  };
  home.sessionVariables = {
    EDITOR = settings.user.editor;
    TERM = setttings.user.terminal;
    BROWSER = settings.user.browser;
  };
}

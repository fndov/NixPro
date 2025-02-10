{ settings, ... }: {
  imports = [
    ../../user/software/commands/sh.nix
    ../../user/software/commands/cli.nix
    ../../user/software/commands/lib.nix
    (../.. + "/user/software/apps/terminal"+("/"+settings.user.terminal)+".nix")
    ../../user/software/apps/collection.nix
    (../.. + "/user/software/apps/browser"+("/"+settings.user.browser)+".nix")
    # ../../user/software/apps/spotify.nix
    # ../../user/software/development/android.nix
    # ../../user/software/development/c.nix
    # ../../user/software/development/cc.nix
    # ../../user/software/development/gd.nix
    # ../../user/software/development/hs.nix
    # ../../user/software/development/rs.nix
    # ../../user/software/development/py-pkgs.nix
    # ../../user/software/development/go.nix
    # ../../user/software/development/zig.nix
  ];
  wayland.windowManager.hyprland.settings = { monitor = "Virtual-1, 1920x1080, 0x0, 1"; };
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

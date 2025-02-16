{ ... }: {
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
}
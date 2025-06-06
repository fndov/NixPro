{ settings, ... }: {
  home-manager.users.${settings.account.name} = {
    wayland.windowManager.hyprland.settings = {
      windowrulev2 = [
        "float, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"
        "nodim, title:^(Picture-in-Picture)$"
        "size 600 400, title:^(nwg-clipman)$"
        "center, title:^(nwg-clipman)$"
      ];
      wayland.windowManager.hyprland.settings.windowrule = [
        "float,title:^(Select a folder)$"
        "float,title:^(Open Folder)$"
        "float,title:^(Save Image)$"
        "float,title:^(Select Image)$"
        "float,title:^(Select file)$"
        "float,title:^(Select folder)$"
        "float,title:^(File Upload)$"
        "float,title:^(Virtual Machine Manager)$"
        "float,title:^(Location)$"
        "float,title:^(Choose Default Install Path)$"
        "float,title:^(Choose target directory)$"
        "float,title:^(Select a Foler for new Wine Prefixes)$"
        "float,title:^(Select Executable)$"
        "float,title:^(Select the setup File)$"
        "float,title:^(Steam Settings)$"
        "float,title:^(Pick game to add)"
        "float,title:^(nwg-clipman)"
        "float,title:^(Select the setup file)"
        "float,title:^(Add Non-Steam Game)"
        "float,title:^(Steam)"
        "float,title:^(Open File)"
        "float,title:^(Open Files)"
        "float,title:^(Open video)"
        "float,title:^(Volume Control)"
      ];
    };
  };
}

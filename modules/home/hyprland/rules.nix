{ ... }: {
  wayland.windowManager.hyprland.settings = { # `hyprctl clients | grep -A 2 "Window"`
    windowrulev2 = [
      "float, title:^(Picture-in-Picture)$"
      "pin, title:^(Picture-in-Picture)$"
      "nodim, title:^(Picture-in-Picture)$"
    ];
    wayland.windowManager.hyprland.settings.windowrule = [
      "float,title:^(Select a folder)$"
      "float,title:^(Open Folder)$"
      "float,title:^(Save Image)$"
      "float,title:^(Select Image)$"
      "float,title:^(Select file)$"
      "float,title:^(Select folder)$"
      "float,title:^(Virtual Machine Manager)$"
      "float,title:^(Location)$"
      "float,title:^(Choose Default Install Path)$"
    ];
  };
}

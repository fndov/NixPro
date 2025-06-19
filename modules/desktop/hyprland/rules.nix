{ settings, ... }: {
  home-manager.users.${settings.account.name} = {
    wayland.windowManager.hyprland.settings = {
      windowrulev2 = [
        # Misc
        "float, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"
        "nodim, title:^(Picture-in-Picture)$"
        "size 600 400, title:^(nwg-clipman)$"
        "center, title:^(nwg-clipman)$"

        # Blacklist windows from waybar
        "plugin:hyprbars:nobar, class:^(obsidian)$"
        "plugin:hyprbars:nobar, class:^(firefox)$"
        "plugin:hyprbars:nobar, class:^(chromium)$"
        "plugin:hyprbars:nobar, class:^(google-chrome)$"
        "plugin:hyprbars:nobar, class:^(code)$"
        "plugin:hyprbars:nobar, class:^(discord)$"
        "plugin:hyprbars:nobar, class:^(pix)$"
        "plugin:hyprbars:nobar, class:^(steam)$"
        "plugin:hyprbars:nobar, class:^(thunar)$"
        "plugin:hyprbars:nobar, class:^(org.gnome.Nautilus)$"
        "plugin:hyprbars:nobar, class:^(net.lutris.Lutris)$"
        "plugin:hyprbars:nobar, class:^(org.pipewire.Helvum)$"
        "plugin:hyprbars:nobar, class:^(com.belmoussaoui.Authenticator)$"
      ];

      windowrule = [
        # Float various dialog windows
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
        "float,title:^(Authenticator)"
      ];
    };
  };
}

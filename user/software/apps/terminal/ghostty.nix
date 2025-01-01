{ userSettings, ... }: {
  # Installed in Root space, waiting for HM option.
  wayland.windowManager.hyprland.settings.exec-once = [ "ghostty --initial-window=false" ];
  home.file."/home/${userSettings.username}/.config/ghostty/config".text = ''
    # Hyprland.
    window-decoration = false

    # Padding.
    # window-padding-y = 0
    # window-padding-x = 0

    # Catppuccin theme.
    palette = 0=#151515
    palette = 1=#ac4142
    palette = 2=#7e8e50
    palette = 3=#e5b567
    palette = 4=#6c99bb
    palette = 5=#9f4e85
    palette = 6=#7dd6cf
    palette = 7=#d0d0d0
    palette = 8=#505050
    palette = 9=#ac4142
    palette = 10=#7e8e50
    palette = 11=#e5b567
    palette = 12=#6c99bb
    palette = 13=#9f4e85
    palette = 14=#7dd6cf
    palette = 15=#f5f5f5
    background = 212121
    foreground = d0d0d0
    cursor-color = d0d0d0
    selection-background = 303030
    selection-foreground = d0d0d0

    # Font.
    font-size = 16
    # font-family = CaskaydiaCove Nerd Font
    # font-family = ZedMono Nerd Font

    # Transparent.
    background-opacity = 0.8

    # Disable exit Message.
    confirm-close-surface = false

    # Init.
    command = "date;fish"

    # Shaders.
    # custom-shader = crt.glsl
    # custom-shader = glitchy.glsl
    # custom-shader = mnoise.glsl # Not working.
    # custom-shader-animation = always

    # Perams.
    gtk-single-instance = true
    quit-after-last-window-closed = false
  '';
}

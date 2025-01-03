{ userSettings, ... }: {
  # Installed in Root space, waiting for HM option.
  wayland.windowManager.hyprland.settings.exec-once = [ "ghostty --initial-window=false" ];
  home.file."/home/${userSettings.username}/.config/ghostty/config".text = ''
    # --- Hyprland ---
    window-decoration = false

    # --- Appearance ---
    theme = catppuccin-mocha
    # window-padding-y = 0
    # window-padding-x = 0
    background-opacity = 0.85
    background-blur-radius = 20

    # --- Font ---
    font-size = 16
    # font-family = CaskaydiaCove Nerd Font
    font-family = ZedMono Nerd Font

    # --- Disable exit Message ---
    confirm-close-surface = false

    # --- Init ---
    command = "date;fish"

    # --- Shaders ---
    # custom-shader = crt.glsl
    # custom-shader = glitchy.glsl
    # custom-shader = mnoise.glsl # Not working.
    # custom-shader-animation = always

    # --- Perams ---
    gtk-single-instance = true
    quit-after-last-window-closed = false
    mouse-hide-while-typing = true
    focus-follows-mouse = true
  '';
}

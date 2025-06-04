{ pkgs, inputs, settings, ... }: {
  home-manager.users.${settings.account.name} = { ... }: let
    unstable = import inputs.nixpkgs-unstable { inherit (pkgs) system; config.allowUnfree = true; };
  in {
    home.packages = with pkgs; [
      unstable.ghostty
      timg
    ];
    home.file."/home/${settings.account.name}/.config/ghostty/config".text = ''
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
      font-family = Noto Mono

      # --- Disable exit Message ---
      confirm-close-surface = false

      # --- Init ---
      command = "date;${settings.account.shell}"

      # --- Shaders ---
      # custom-shader = crt.glsl
      # custom-shader = glitchy.glsl
      # custom-shader = mnoise.glsl # Not working.
      # custom-shader-animation = always

      # --- Perams ---
      clipboard-paste-protection = false
      gtk-single-instance = true
      quit-after-last-window-closed = false
      mouse-hide-while-typing = true
      focus-follows-mouse = true
    '';
  } // (if settings.desktop.type == "hyprland" then {
    wayland.windowManager.hyprland.settings.exec-once = [
      "nice -1 ghostty --initial-window=false"
    ];
  } else {});
}

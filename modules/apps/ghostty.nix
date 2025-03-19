{ pkgs, inputs, settings, ... }: let
  unstable = import inputs.nixpkgs-unstable { inherit (pkgs) system; config.allowUnfree = true; };
in {
  home-manager.users.${settings.user.name} = {
    home.packages = with pkgs; [
      unstable.ghostty
    ];
    home.file."/home/${settings.user.name}/.config/ghostty/config".text = ''
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
      # font-family = ZedMono Nerd Font
      font-family = Noto Mono

      # --- Disable exit Message ---
      confirm-close-surface = false

      # --- Init ---
      command = "date;${settings.user.shell}"

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
  } // (if settings.desktop.type == "hyprland" then {
    wayland.windowManager.hyprland.settings.exec-once = [ "ghostty --initial-window=false" ];
  } else {});
}

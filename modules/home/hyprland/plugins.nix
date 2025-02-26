{inputs, pkgs, ...}: {
  wayland.windowManager.hyprland = {
    plugins = [
      # inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
      # inputs.hyprland-plugins.packages.${pkgs.system}.hyprtrails
    ];
  };
}

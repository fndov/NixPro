{ pkgs, lib, ... }: {
  home.packages = [ pkgs.kitty ];
  programs.kitty.enable = true;
  programs.kitty.settings.background_opacity = lib.mkForce "0.85";
  programs.kitty.settings.modify_font = "cell_width 90%";
}

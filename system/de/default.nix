{ pkgs, settings, ... }: 
if settings.desktop.type != "de" || settings.desktop.enable != true then
  {}
else if settings.desktop.wm == "plasma" then {
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.ly.enable = true;
}
else if settings.desktop.wm == "gnome" then {
  # gnome configuration here
}
else if settings.desktop.wm == "cinnamon" then {
  # cinnamon configuration here
}
else if settings.desktop.wm == "xfce" then {
  # xfce configuration here
}
else {}

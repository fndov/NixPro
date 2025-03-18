{ pkgs, settings, ... }: {
  home-manager.users.${settings.user.name} = { pkgs, ... }: {
    home.packages = [ pkgs.flatpak ];
    home.sessionVariables = {
      XDG_DATA_DIRS = "$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share"; # lets flatpak work
    };
    services.flatpak.enable = true;
    services.flatpak.update.onActivation = true;
  };
}

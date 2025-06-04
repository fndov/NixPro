{ pkgs, settings, ... }: {
  home-manager.users.${settings.account.name} = {
    qt = {
      enable = true;
      platformTheme.name = "qtct";
      style.name = "kvantum";
    };
    xdg.configFile = {
      "Kvantum/kvantum.kvconfig".text = ''
        [General]
        theme=GraphiteNordDark
      '';
      "Kvantum/GraphiteNord".source = "${pkgs.graphite-kde-theme}/share/Kvantum/GraphiteNord";
    };
    gtk = {
      enable = true;
      iconTheme = {
        package = pkgs.catppuccin-papirus-folders.override {
          flavor = "macchiato";
          accent = "lavender";
        };
        name = "Papirus-Dark";
      };
      theme = {
        name = "catppuccin-macchiato-mauve-compact";
        package = pkgs.catppuccin-gtk.override {
          accents =  ["mauve" ];
          variant = "macchiato";
          size = "compact";
        };
      };
      gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
      gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
    };
  };
}

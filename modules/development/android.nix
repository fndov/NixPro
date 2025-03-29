{ pkgs, settings, ... }: {
  home-manager.users.${settings.account.name} = { pkgs, ... }: {
    home.packages = with pkgs; [
      android-tools
      android-udev-rules
    ];
  };
}

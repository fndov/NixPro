{ pkgs, settings, ... }: {
  home-manager.users.${settings.account.name} = {
    home.packages = with pkgs; [
      android-tools
      android-udev-rules
    ];
  };
}

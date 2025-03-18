{ pkgs, settings, ... }: {
  home-manager.users.${settings.user.name} = { pkgs, ... }: {
    home.packages = with pkgs; [
      # rustup
      cargo
    ];
  };
}

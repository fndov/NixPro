{ pkgs, settings, ... }: {
  home-manager.users.${settings.account.name} = {
    home.packages = with pkgs; [
      rustup
      gcc
      # cargo
    ];
  };
}

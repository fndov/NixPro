{ pkgs, settings, ... }: {
  home-manager.users.${settings.account.name} = {
    home.packages = with pkgs; [
      rustup
      # cargo
      # rust-analyzer
      gcc # for some reason I might need it
    ];
  };
}

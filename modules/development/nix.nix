{ pkgs, settings, ... }: {
  home-manager.users.${settings.account.name} = {
    home.packages = with pkgs; [
      nix-prefetch-github
      prefetch-npm-deps
      jq
      nh
      nixd
      nil
    ];
  };
}

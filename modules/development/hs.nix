{ pkgs, settings, ... }: {
  home-manager.users.${settings.user.name} = { pkgs, ... }: {
    home.packages = with pkgs; [
      haskellPackages.haskell-language-server
      haskellPackages.stack
    ];
  };
}

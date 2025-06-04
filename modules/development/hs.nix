{ pkgs, settings, ... }: {
  home-manager.users.${settings.account.name} = { ... }: {
    home.packages = with pkgs; [
      haskellPackages.haskell-language-server
      haskellPackages.stack
    ];
  };
}

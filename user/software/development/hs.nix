{ pkgs, ... }: {
  home.packages = with pkgs; [
    haskellPackages.haskell-language-server
    haskellPackages.stack
  ];
}

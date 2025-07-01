{ pkgs, settings, inputs, ... }: {
  home-manager.users.${settings.account.name} = { ... }: let
    unstable = import inputs.nixpkgs-unstable { inherit (pkgs) system; };
  in {
    home.packages = with pkgs; [
      nix-prefetch-github
      prefetch-npm-deps
      jq
      nh
      unstable.nixd
      unstable.nil
    ];
  };
}

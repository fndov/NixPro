{ pkgs, settings, inputs, ... }: {
  home-manager.users.${settings.account.name} = { ... }: let
    unstable = import inputs.nixpkgs-unstable { inherit (pkgs) system; };
  in {
    home.packages = with pkgs; [
      clang-tools
      clang
      gnumake
      cmake
      autoconf
      automake
      libtool
    ];
  };
}

{ pkgs, settings, inputs, ... }: {
  home-manager.users.${settings.account.name} = { pkgs, settings, inputs, ... }: let
    unstable = import inputs.nixpkgs-unstable { inherit (pkgs) system; };
  in {
    home.packages = with pkgs; [
      unstable.clang-tools # Includes clang-tidy, clang-format, etc.
      unstable.clang
      gnumake
      cmake
      autoconf
      automake
      libtool
    ];
  };
}

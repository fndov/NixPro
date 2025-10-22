{ pkgs, settings, ... }: {
  home-manager.users.${settings.account.name} = {
    home.packages = with pkgs; [
      clang-tools
      gnumake
      cmake
      autoconf
      automake
      libtool
      # clang
    ];
  };
}

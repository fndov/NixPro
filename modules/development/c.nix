{ pkgs, settings, ... }: {
  home-manager.users.${settings.account.name} = {
    home.packages = with pkgs; [
      gcc
      gdb
      valgrind
      cmake
      pkg-config
      lld
      binutils
      ccache
      strace
      ltrace
      cppcheck
      ninja
      /*
        gcov
      */
    ];
  };
}

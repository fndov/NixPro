{ pkgs, settings, ... }: {
  home-manager.users.${settings.user.name} = { pkgs, ... }: {
    home.packages = with pkgs; [
      # gcov         # Code coverage analysis (part of gcc)
      gcc            # GNU Compiler Collection.
      gdb            # GNU Debugger
      valgrind       # Memory debugging and profiling
      cmake          # Build system generator
      pkg-config     # Library configuration utility
      lld            # LLVM linker
      binutils       # Essential tools (e.g., assembler, linker)
      ccache         # Compiler cache for speeding up builds
      strace         # System call tracer
      ltrace         # Library call tracer
      cppcheck       # Static analysis for C/C++
      ninja          # Fast build system (alternative to make)
    ];
  };
}

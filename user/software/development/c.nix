{ pkgs, ... }:
{
  # C.
  home.packages = with pkgs; [
    gcc            # GNU Compiler Collection.
    clang          # Clang/LLVM Compiler.
    gdb            # GNU Debugger
    valgrind       # Memory debugging and profiling
    cmake          # Build system generator
    make           # Build automation tool
    pkg-config     # Library configuration utility
    lld            # LLVM linker
    binutils       # Essential tools (e.g., assembler, linker)
    ccache         # Compiler cache for speeding up builds
    strace         # System call tracer
    ltrace         # Library call tracer
    cppcheck       # Static analysis for C/C++
    gcov           # Code coverage analysis (part of gcc)
    clang-tools    # Includes clang-tidy, clang-format, etc.
    ninja          # Fast build system (alternative to make)
  ];
}

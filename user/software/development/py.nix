{ pkgs, ... }:
{
  # Python.
  home.packages = with pkgs; [
    python3Full
    imath
    pystring
  ];
}

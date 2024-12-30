{ pkgs, ... }:
{
  # Gamedev.
  home.packages = with pkgs; [
    godot_4
  ];
}

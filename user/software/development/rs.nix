{ pkgs, ... }:
{
  # Rust.
  home.packages = with pkgs; [
    rustup
    cargo
  ];
}

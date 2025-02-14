{ pkgs, ... }: {
  home.packages = with pkgs; [
    # rustup
    cargo
  ];
}

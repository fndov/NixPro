{ pkgs, userSettings, ... }: {
  home.packages = with pkgs; [
    intel-one-mono
    userSettings.fontPkg
    jetbrains-mono
    source-han-sans-japanese
    source-han-serif-japanese
    source-sans-pro
    source-serif-pro
    source-code-pro
    fira-code
    fira-code-symbols
    arkpandora_ttf
    font-awesome
    powerline-fonts
    powerline-symbols
  ];
  # Breaks powerline prompt.
  # fonts.fontconfig.defaultFonts = {
  #   monospace = [ userSettings.font ];
  #   sansSerif = [ userSettings.font ];
  #   serif = [ userSettings.font ];
  # };
}

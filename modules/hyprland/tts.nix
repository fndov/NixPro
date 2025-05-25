{ settings, pkgs, ... }: {
  home-manager.users.${settings.account.name} = { ... }: {
    home.packages = with pkgs; [ alsa-utils piper-tts ];
    wayland.windowManager.hyprland.settings.bind = [
      # Impure, download your own tts model and make the directory.
      ''SUPER,S,exec, var=$(wl-paste); echo "$var" | piper --model ~/.tts/en_GB-cori-high.onnx --output-raw --length_scale 0.625 --sentence_silence 0.01 | aplay -r 22050 -f S16_LE -t raw -''
    ];
  };
}

{ settings, ... }: {
  wayland.windowManager.hyprland.settings.bind = [
    "SUPER,X,exec,if hyprctl clients | grep -q scratch_term; then echo 'scratch_term already running'; else ${settings.user.terminal} --class scratch_term; fi"
    "SUPER,X,togglespecialworkspace,scratch_term"
  ];
  wayland.windowManager.hyprland.settings.windowrule = [
    "float,class:^(scratch_term)$"
    "size 80% 85%,class:^(scratch_term)$"
    "workspace special:scratch_term,class:^(scratch_term)$"
    "center,class:^(scratch_term)$"
    "opacity 0.80,class:^(scratch_term)$"
  ];
}

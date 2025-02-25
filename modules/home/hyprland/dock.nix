{
  home.file.".config/nwg-dock-hyprland/style.css".text = ''
    window {
        background: #1e1e2e;  /* Catppuccin Mocha base */
        border-radius: 10px;
        border-style: none;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.3);
    }

    #box {
        padding: 4px;
        border-radius: 10px;
    }

    #active {
        border-bottom: 2px solid #cba6f7;  /* Catppuccin Mocha mauve */
    }

    button, image {
        background: none;
        border-style: none;
        box-shadow: none;
        color: #cdd6f4;  /* Catppuccin Mocha text */
    }

    button {
        padding: 4px;
        margin: 2px;
        color: #cdd6f4;  /* Catppuccin Mocha text */
        font-size: 12px;
        border-radius: 8px;  /* Changed to rounded rectangle */
        transition: all 0.2s ease;
    }

    button:hover {
        background-color: #313244;  /* Catppuccin Mocha surface0 */
        border-radius: 8px;  /* Changed to rounded rectangle */
    }

    button:focus {
        box-shadow: none;
    }
  '';

  wayland.windowManager.hyprland.extraConfig = ''
    exec-once = nwg-dock-hyprland -i 60 -d -mb 10
  '';
}

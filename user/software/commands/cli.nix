{ pkgs, settings, ... }: {
  home.packages = with pkgs; [ /* Essential utils */
    nixd
    nil
    nixfmt-classic
    syncthing
    zip
    unzip
    glib
    glibc
    usbutils
    hwinfo
    openssh
    pciutils
    curl
    git
    sshpass
    wget
  ];
  programs.git.enable = true;
  programs.git.userName = settings.user.name;
  programs.git.userEmail = settings.user.email;
  programs.git.extraConfig = {
    core.editor = settings.user.editor;
    # init.defaultBranch = "main";
    safe.directory = [
      ("/home/" + settings.user.name + "/.nixpro")
      ("/home/" + settings.user.name + "/.nixpro/.git")
    ];
  };
}

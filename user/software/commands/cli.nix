{ pkgs, userSettings, ... }: {
  home.packages = with pkgs; [
    # Essential utils:
    timg
    nixd
    nil
    nixfmt-classic
    syncthing
    zip
    glib
    glibc
    usbutils
    hwinfo
    openssh
    pciutils
    curl
    git
  ];
  programs.git.enable = true;
  programs.git.userName = userSettings.name;
  programs.git.userEmail = userSettings.email;
  programs.git.extraConfig = {
    # init.defaultBranch = "main";
    safe.directory = [
      ("/home/" + userSettings.username + "/.nixpro")
      ("/home/" + userSettings.username + "/.nixpro/.git")
    ];
  };
}

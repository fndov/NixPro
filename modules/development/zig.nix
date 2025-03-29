{ pkgs, settings, ... }: {
  home-manager.users.${settings.account.name} = { pkgs, ... }: {
    home.packages = with pkgs; [
      zig
      zls
    ];
  };
}

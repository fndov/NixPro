{ pkgs, lib, inputs, settings, ... }: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  home-manager.users.${settings.account.name} = { pkgs, lib, ... }: {
    imports = [ inputs.spicetify-nix.homeManagerModules.default ];
    programs.spicetify.enable = true;
    programs.spicetify.enabledExtensions = with spicePkgs.extensions; [
      adblockify
      hidePodcasts
      shuffle
    ];
    programs.spicetify.theme = spicePkgs.themes.catppuccin;
    programs.spicetify.colorScheme = "mocha";
  };
}

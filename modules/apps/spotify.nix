{ pkgs, inputs, settings, ... }: {
  home-manager.users.${settings.account.name} = { ... }: let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in {
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

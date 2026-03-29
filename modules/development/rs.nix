{ pkgs, settings, ... }: {
  home-manager.users.${settings.account.name} = {
    home.packages = with pkgs; [
      # rustup
      # # cargo
      # # rust-analyzer
      # gcc # for some reason I might need it
      # rustlings # needed for working on rustlings
      # rustc

      rustc
      cargo
      rust-analyzer
      gcc

      rustlings # needed for working on rustlings
    ];
    home.sessionVariables = {
      RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";
    };
  };
}
/*
This actually works for zed, the one thing you have to do though is set the lsp using `whereis rust-analyzer`

  "lsp": {
    "rust-analyzer": {
      "binary": {
        "path": "/nix/store/ya4kb9sdf9rl09nid28f5pfr106kcyxb-user-environment/bin/rust-analyzer"
      }
    }
  },

*/

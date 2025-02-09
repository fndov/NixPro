{ settings, ... }: {
  imports = [ /* Home-Manager */
    ../../user/software/commands/sh.nix
    ../../user/software/commands/cli.nix
    ../../user/software/commands/lib.nix
    ../../user/software/development/cc.nix
    # ../../user/software/development/ zig go py-pkgs rs hs c cc android     
  ];
  # https://github.com/sonowz/vscode-remote-wsl-nixos/tree/master
  home.file.".vscode-server/server-env-setup".text = ''
    # This shell script is run before checking for vscode version updates.
    # If a newer version is downloaded, this script won't patch that version,
    # resulting in error. Therefore retry is required to patch it.

    echo "== '~/.vscode-server/server-env-setup' SCRIPT START =="

    # Make sure that basic commands are available
    PATH=$PATH:/run/current-system/sw/bin/

    # This shell script uses nixpkgs branch from OS version.
    NIXOS_VERSION=$(nixos-version | cut -d "." -f1,2)
    echo "NIXOS_VERSION detected as \"$NIXOS_VERSION\""

    NIXPKGS_BRANCH=nixos-$NIXOS_VERSION
    PKGS_EXPRESSION=nixpkgs/$NIXPKGS_BRANCH#pkgs

    # Use hardcoded VSCode server directory
    VSCODE_SERVER_DIR="$HOME/.vscode-server"
    echo "Using vscode directory: $VSCODE_SERVER_DIR"

    echo "Patching nodejs binaries..."
    nix shell $PKGS_EXPRESSION.patchelf $PKGS_EXPRESSION.stdenv.cc -c bash -c "
        for versiondir in $VSCODE_SERVER_DIR/bin/*/; do
            # Currently only "libstdc++.so.6" needs to be patched
            patchelf --set-interpreter \"\$(cat \$(nix eval --raw $PKGS_EXPRESSION.stdenv.cc)/nix-support/dynamic-linker)\" --set-rpath \"\$(nix eval --raw $PKGS_EXPRESSION.stdenv.cc.cc.lib)/lib/\" \"\$versiondir\"\"node_modules/node-pty/build/Release/spawn-helper\"
            patchelf --set-interpreter \"\$(cat \$(nix eval --raw $PKGS_EXPRESSION.stdenv.cc)/nix-support/dynamic-linker)\" --set-rpath \"\$(nix eval --raw $PKGS_EXPRESSION.stdenv.cc.cc.lib)/lib/\" \"\$versiondir\"\"node\"
        done
    "

    echo "== '~/.vscode-server/server-env-setup' SCRIPT END =="
  '';

  xdg.enable = true;
  xdg.mime.enable = true;
  xdg.mimeApps.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    templates = "/home/${settings.user.name}/Templates";
    download = "/home/${settings.user.name}/Downloads";
    documents = "/home/${settings.user.name}/Documents";
    desktop = null;
    publicShare = null;
    extraConfig = {
      XDG_ARCHIVE_DIR = "/home/${settings.user.name}/Archive";
      XDG_VM_DIR = "/home/${settings.user.name}/Machines";
      XDG_ORG_DIR = "/home/${settings.user.name}/Org";
    };
  };
}

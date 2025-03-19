{ lib, pkgs, settings, ... }: {
  home-manager.users.${settings.user.name} = { ... }: {
    config = lib.mkMerge [
      (lib.mkIf (settings.profile == "standalone") {
        home.packages = with pkgs; [
          (writeShellScriptBin "nixgu" ''
            echo "nixsw | Switch configuration"
            echo "nixup | Upgrade system"
            echo "nixdr | Dry run"
            echo "nixts | Test build"
            echo "nixbo | Boot loader"
            echo "nixrl | Rollback"
            echo "nixgu | Garbage collect"
            echo "nixop | Optimise system"
            echo "nixar | Archive system"
            echo "nixtr | Troubleshoot"
            echo "nixrs | Restart nix-deamon"
            echo "nixls | List generations"
            echo "nixim | Build Image"
            echo "nixpk | Enter package"
          '')
          (writeShellScriptBin "nixsw" ''
            echo '# sudo nixos-rebuild --upgrade switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
            sudo nixos-rebuild --upgrade switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}
          '')
          (writeShellScriptBin "nixbo" ''
            echo '# sudo nixos-rebuild boot --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
            sudo nixos-rebuild boot --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}
          '')
          (writeShellScriptBin "nixts" ''
            echo '# sudo nixos-rebuild test --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
            sudo nixos-rebuild test --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}
          '')
          (writeShellScriptBin "nixdr" ''
            echo '# sudo nixos-rebuild dry-run --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
            sudo nixos-rebuild dry-run --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}
          '')
          (writeShellScriptBin "nixrl" ''
            echo '# sudo nixos-rebuild switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name} --rollback'
            sudo nixos-rebuild switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name} --rollback
          '')
          (writeShellScriptBin "nixup" ''
            echo '# nix flake update --flake /home/${settings.user.name}/${settings.system.flakePath}'
            nix flake update --flake /home/${settings.user.name}/${settings.system.flakePath}
          '')
          (writeShellScriptBin "nixar" ''
            echo '# nix flake archive /home/${settings.user.name}/${settings.system.flakePath}'
            nix flake archive /home/${settings.user.name}/${settings.system.flakePath}
          '')
          (writeShellScriptBin "nixtr" ''
            echo '# journalctl -xe --unit home-manager-${settings.user.name}'
            journalctl -xe --unit home-manager-${settings.user.name}
          '')
          (writeShellScriptBin "nixim" ''
            echo '# nix build /home/${settings.user.name}/${settings.system.flakePath}#nixosConfigurations.${settings.user.name}.config.system.build.isoImage --impure'
            nix build /home/${settings.user.name}/${settings.system.flakePath}#nixosConfigurations.${settings.user.name}.config.system.build.isoImage --impure
          '')
          (writeShellScriptBin "nixgc" ''
            echo '# sudo nix-collect-garbage --delete-older-than 30d'
            sudo nix-collect-garbage --delete-older-than 30d
            echo '# nix-collect-garbage --delete-older-than 30d'
            nix-collect-garbage --delete-older-than 30d
          '')
          (writeShellScriptBin "nixop" ''
            echo '# sudo nix-store --optimise'
            sudo nix-store --optimise
            echo '# nix-store --optimise'
            nix-store --optimise
          '')
          (writeShellScriptBin "nixrs" ''
            echo '# sudo systemctl restart nix-daemon'
            sudo systemctl restart nix-daemon
          '')
          (writeShellScriptBin "nixls" ''
            echo '# sudo nix-env --list-generations --profile /nix/var/nix/profiles/system | wc -l'
            sudo nix-env --list-generations --profile /nix/var/nix/profiles/system | wc -l
          '')
          (pkgs.writeShellScriptBin "nixpk" ''
            if [ $# -ne 1 ]; then
            echo "Usage: nixpk <package>"
            exit 1
            fi
            dir=$(nix-build "${pkgs.path}" -A "$1" --no-out-link) || exit 1
            cd "$dir" && exec $SHELL
          '')
        ];
      })

      (lib.mkIf (settings.driver.graphics == "image") {
        home.packages = with pkgs; [
          (writeShellScriptBin "nixgu" ''
            echo "nixsw | Switch configuration"
            echo "nixup | Upgrade system"
            echo "nixdr | Dry run"
            echo "nixts | Test build"
            echo "nixbo | Boot loader"
            echo "nixrl | Rollback"
            echo "nixgu | Garbage collect"
            echo "nixop | Optimise system"
            echo "nixar | Archive system"
            echo "nixtr | Troubleshoot"
            echo "nixls | List generations"
            echo "nixpk | Enter package"
          '')
          (writeShellScriptBin "nixsw" ''
            echo '# sudo nixos-rebuild --upgrade switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
            sudo nixos-rebuild --upgrade switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}
          '')
          (writeShellScriptBin "nixbo" ''
            echo '# sudo nixos-rebuild boot --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
            sudo nixos-rebuild boot --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}
          '')
          (writeShellScriptBin "nixts" ''
            echo '# sudo nixos-rebuild test --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
            sudo nixos-rebuild test --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}
          '')
          (writeShellScriptBin "nixdr" ''
            echo '# sudo nixos-rebuild dry-run --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
            sudo nixos-rebuild dry-run --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}
          '')
          (writeShellScriptBin "nixrl" ''
            echo '# sudo nixos-rebuild switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name} --rollback'
            sudo nixos-rebuild switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name} --rollback
          '')
          (writeShellScriptBin "nixup" ''
            echo '# nix flake update --flake /home/${settings.user.name}/${settings.system.flakePath}'
            nix flake update --flake /home/${settings.user.name}/${settings.system.flakePath}
          '')
          (writeShellScriptBin "nixar" ''
            echo '# nix flake archive /home/${settings.user.name}/${settings.system.flakePath}'
            nix flake archive /home/${settings.user.name}/${settings.system.flakePath}
          '')
          (writeShellScriptBin "nixtr" ''
            echo '# journalctl -xe --unit home-manager-${settings.user.name}'
            journalctl -xe --unit home-manager-${settings.user.name}
          '')
          (writeShellScriptBin "nixgc" ''
            echo '# sudo nix-collect-garbage'
            sudo nix-collect-garbage
            echo '# nix-collect-garbage'
            nix-collect-garbage
          '')
          (writeShellScriptBin "nixop" ''
            echo '# sudo nix-store --optimise'
            sudo nix-store --optimise
            echo '# nix-store --optimise'
            nix-store --optimise
          '')
          (writeShellScriptBin "nixls" ''
            echo '# sudo nix-env --list-generations --profile /nix/var/nix/profiles/system | wc -l'
            sudo nix-env --list-generations --profile /nix/var/nix/profiles/system | wc -l
          '')
          (pkgs.writeShellScriptBin "nixpk" ''
            if [ $# -ne 1 ]; then
            echo "Usage: nixpk <package>"
            exit 1
            fi
            dir=$(nix-build "${pkgs.path}" -A "$1" --no-out-link) || exit 1
            cd "$dir" && exec $SHELL
          '')
        ];
      })

      (lib.mkIf (settings.driver.graphics == "microsoft") {
        home.packages = with pkgs; [
          (writeShellScriptBin "nixgu" ''
            echo "nixsw | Switch configuration"
            echo "nixup | Upgrade system"
            echo "nixdr | Dry run"
            echo "nixts | Test build"
            echo "nixbo | Boot loader"
            echo "nixrl | Rollback"
            echo "nixgu | Garbage collect"
            echo "nixop | Optimise system"
            echo "nixar | Archive system"
            echo "nixtr | Troubleshoot"
            echo "nixrs | Restart nix-deamon"
            echo "nixls | List generations"
            echo "nixim | Build Image"
            echo "nixpk | Enter package"
          '')
          (writeShellScriptBin "nixsw" ''
            echo '# sudo nixos-rebuild --upgrade switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
            sudo nixos-rebuild --upgrade switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}
          '')
          (writeShellScriptBin "nixbo" ''
            echo '# sudo nixos-rebuild boot --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
            sudo nixos-rebuild boot --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}
          '')
          (writeShellScriptBin "nixts" ''
            echo '# sudo nixos-rebuild test --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
            sudo nixos-rebuild test --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}
          '')
          (writeShellScriptBin "nixdr" ''
            echo '# sudo nixos-rebuild dry-run --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
            sudo nixos-rebuild dry-run --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}
          '')
          (writeShellScriptBin "nixrl" ''
            echo '# sudo nixos-rebuild switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name} --rollback'
            sudo nixos-rebuild switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name} --rollback
          '')
          (writeShellScriptBin "nixup" ''
            echo '# nix flake update --flake /home/${settings.user.name}/${settings.system.flakePath}'
            nix flake update --flake /home/${settings.user.name}/${settings.system.flakePath}
          '')
          (writeShellScriptBin "nixar" ''
            echo '# nix flake archive /home/${settings.user.name}/${settings.system.flakePath}'
            nix flake archive /home/${settings.user.name}/${settings.system.flakePath}
          '')
          (writeShellScriptBin "nixtr" ''
            echo '# journalctl -xe --unit home-manager-${settings.user.name}'
            journalctl -xe --unit home-manager-${settings.user.name}
          '')
          (writeShellScriptBin "nixim" ''
            echo '# nix build /home/${settings.user.name}/${settings.system.flakePath}#nixosConfigurations.${settings.user.name}.config.system.build.isoImage --impure'
            nix build /home/${settings.user.name}/${settings.system.flakePath}#nixosConfigurations.${settings.user.name}.config.system.build.isoImage --impure
          '')
          (writeShellScriptBin "nixgc" ''
            echo '# sudo nix-collect-garbage --delete-older-than 30d'
            sudo nix-collect-garbage --delete-older-than 30d
            echo '# nix-collect-garbage --delete-older-than 30d'
            nix-collect-garbage --delete-older-than 30d
          '')
          (writeShellScriptBin "nixop" ''
            echo '# sudo nix-store --optimise'
            sudo nix-store --optimise
            echo '# nix-store --optimise'
            nix-store --optimise
          '')
          (writeShellScriptBin "nixrs" ''
            echo '# sudo systemctl restart nix-daemon'
            sudo systemctl restart nix-daemon
          '')
          (writeShellScriptBin "nixls" ''
            echo '# sudo nix-env --list-generations --profile /nix/var/nix/profiles/system | wc -l'
            sudo nix-env --list-generations --profile /nix/var/nix/profiles/system | wc -l
          '')
          (pkgs.writeShellScriptBin "nixpk" ''
            if [ $# -ne 1 ]; then
            echo "Usage: nixpk <package>"
            exit 1
            fi
            dir=$(nix-build "${pkgs.path}" -A "$1" --no-out-link) || exit 1
            cd "$dir" && exec $SHELL
          '')
        ];
      })

      (lib.mkIf (settings.driver.graphics == "server") {
        home.packages = with pkgs; [
          (writeShellScriptBin "nixgu" ''
            echo "nixsw | Switch configuration"
            echo "nixup | Upgrade system"
            echo "nixdr | Dry run"
            echo "nixts | Test build"
            echo "nixbo | Boot loader"
            echo "nixrl | Rollback"
            echo "nixgu | Garbage collect"
            echo "nixop | Optimise system"
            echo "nixar | Archive system"
            echo "nixtr | Troubleshoot"
            echo "nixls | List generations"
          '')
          (writeShellScriptBin "nixsw" ''
            echo '# sudo nixos-rebuild --upgrade switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
            sudo nixos-rebuild --upgrade switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}
          '')
          (writeShellScriptBin "nixbo" ''
            echo '# sudo nixos-rebuild boot --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
            sudo nixos-rebuild boot --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}
          '')
          (writeShellScriptBin "nixts" ''
            echo '# sudo nixos-rebuild test --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
            sudo nixos-rebuild test --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}
          '')
          (writeShellScriptBin "nixdr" ''
            echo '# sudo nixos-rebuild dry-run --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
            sudo nixos-rebuild dry-run --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}
          '')
          (writeShellScriptBin "nixrl" ''
            echo '# sudo nixos-rebuild switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name} --rollback'
            sudo nixos-rebuild switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name} --rollback
          '')
          (writeShellScriptBin "nixup" ''
            echo '# sudo nix flake update --flake /home/${settings.user.name}/${settings.system.flakePath}'
            sudo nix flake update --flake /home/${settings.user.name}/${settings.system.flakePath}
            echo '# sudo nixos-rebuild --upgrade switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
            sudo nixos-rebuild --upgrade switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}
          '')
          (writeShellScriptBin "nixar" ''
            echo '# nix flake archive /home/${settings.user.name}/${settings.system.flakePath}'
            nix flake archive /home/${settings.user.name}/${settings.system.flakePath}
          '')
          (writeShellScriptBin "nixtr" ''
            echo '# journalctl -xe --unit home-manager-${settings.user.name}'
            journalctl -xe --unit home-manager-${settings.user.name}
          '')
          (writeShellScriptBin "nixim" ''
            echo '# nix build /home/${settings.user.name}/${settings.system.flakePath}#nixosConfigurations.${settings.user.name}.config.system.build.isoImage --impure'
            nix build /home/${settings.user.name}/${settings.system.flakePath}#nixosConfigurations.${settings.user.name}.config.system.build.isoImage --impure
          '')
          (writeShellScriptBin "nixgc" ''
            echo '# sudo nix-collect-garbage'
            sudo nix-collect-garbage
            echo '# nix-collect-garbage'
            nix-collect-garbage
          '')
          (writeShellScriptBin "nixop" ''
            echo '# sudo nix-store --optimise'
            sudo nix-store --optimise
            echo '# nix-store --optimise'
            nix-store --optimise
          '')
          (writeShellScriptBin "nixrs" ''
            echo '# sudo systemctl restart nix-daemon'
            sudo systemctl restart nix-daemon
          '')
          (writeShellScriptBin "nixls" ''
            echo '# sudo nix-env --list-generations --profile /nix/var/nix/profiles/system | wc -l'
            sudo nix-env --list-generations --profile /nix/var/nix/profiles/system | wc -l
          '')
        ];
      })

      (lib.mkIf (settings.profile == "apple") {})

      (lib.mkIf (settings.driver.graphics == "virtual-machine") {
        home.packages = with pkgs; [
          (writeShellScriptBin "nixgu" ''
            echo "nixsw | Switch configuration"
            echo "nixup | Upgrade system"
            echo "nixdr | Dry run"
            echo "nixts | Test build"
            echo "nixbo | Boot loader"
            echo "nixrl | Rollback"
            echo "nixgu | Garbage collect"
            echo "nixop | Optimise system"
            echo "nixar | Archive system"
            echo "nixtr | Troubleshoot"
            echo "nixrs | Restart nix-deamon"
            echo "nixls | List generations"
            echo "nixim | Build Image"
            echo "nixpk | Enter package"
          '')
          (writeShellScriptBin "nixsw" ''
            echo '# sudo nixos-rebuild --upgrade switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
            sudo nixos-rebuild --upgrade switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}
          '')
          (writeShellScriptBin "nixbo" ''
            echo '# sudo nixos-rebuild boot --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
            sudo nixos-rebuild boot --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}
          '')
          (writeShellScriptBin "nixts" ''
            echo '# sudo nixos-rebuild test --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
            sudo nixos-rebuild test --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}
          '')
          (writeShellScriptBin "nixdr" ''
            echo '# sudo nixos-rebuild dry-run --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
            sudo nixos-rebuild dry-run --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}
          '')
          (writeShellScriptBin "nixrl" ''
            echo '# sudo nixos-rebuild switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name} --rollback'
            sudo nixos-rebuild switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name} --rollback
          '')
          (writeShellScriptBin "nixup" ''
            echo '# nix flake update --flake /home/${settings.user.name}/${settings.system.flakePath}'
            nix flake update --flake /home/${settings.user.name}/${settings.system.flakePath}
          '')
          (writeShellScriptBin "nixar" ''
            echo '# nix flake archive /home/${settings.user.name}/${settings.system.flakePath}'
            nix flake archive /home/${settings.user.name}/${settings.system.flakePath}
          '')
          (writeShellScriptBin "nixtr" ''
            echo '# journalctl -xe --unit home-manager-${settings.user.name}'
            journalctl -xe --unit home-manager-${settings.user.name}
          '')
          (writeShellScriptBin "nixim" ''
            echo '# nix build /home/${settings.user.name}/${settings.system.flakePath}#nixosConfigurations.${settings.user.name}.config.system.build.isoImage --impure'
            nix build /home/${settings.user.name}/${settings.system.flakePath}#nixosConfigurations.${settings.user.name}.config.system.build.isoImage --impure
          '')
          (writeShellScriptBin "nixgc" ''
            echo '# sudo nix-collect-garbage --delete-older-than 30d'
            sudo nix-collect-garbage --delete-older-than 30d
            echo '# nix-collect-garbage --delete-older-than 30d'
            nix-collect-garbage --delete-older-than 30d
          '')
          (writeShellScriptBin "nixop" ''
            echo '# sudo nix-store --optimise'
            sudo nix-store --optimise
            echo '# nix-store --optimise'
            nix-store --optimise
          '')
          (writeShellScriptBin "nixrs" ''
            echo '# sudo systemctl restart nix-daemon'
            sudo systemctl restart nix-daemon
          '')
          (writeShellScriptBin "nixls" ''
            echo '# sudo nix-env --list-generations --profile /nix/var/nix/profiles/system | wc -l'
            sudo nix-env --list-generations --profile /nix/var/nix/profiles/system | wc -l
          '')
          (pkgs.writeShellScriptBin "nixpk" ''
            if [ $# -ne 1 ]; then
            echo "Usage: nixpk <package>"
            exit 1
            fi
            dir=$(nix-build "${pkgs.path}" -A "$1" --no-out-link) || exit 1
            cd "$dir" && exec $SHELL
          '')
        ];
      })
    ];
  };
}

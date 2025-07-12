{ lib, pkgs, settings, ... }: {
  home-manager.users.${settings.account.name} = {
    config = lib.mkMerge [

      (lib.mkIf (settings.profile == "workstation") {
        home.packages = with pkgs; [

          (writeShellScriptBin "nixgu" ''
            echo "nixsw | Switch configuration"
            echo "nixup | Upgrade system"
            echo "nixdr | Dry run"
            echo "nixts | Test build"
            echo "nixbo | Boot loader"
            echo "nixrl | Rollback"
            echo "nixgc | Garbage collect"
            echo "nixca | Collect all"
            echo "nixop | Optimise system"
            echo "nixar | Archive system"
            echo "nixtr | Troubleshoot"
            echo "nixrs | Restart nix-daemon"
            echo "nixls | List generations"
            echo "nixim | Build Image"
            echo "nixpk | Enter package"
          '')

          (writeShellScriptBin "nixsw" ''
            echo '# sudo nice -1 nixos-rebuild switch --flake /home/${settings.account.name}/${settings.system.flakePath}#workstation'
            sudo nixos-rebuild switch --flake /home/${settings.account.name}/${settings.system.flakePath}#workstation
          '')

          (writeShellScriptBin "nixbo" ''
            echo '# sudo nice -1 nixos-rebuild boot --flake /home/${settings.account.name}/${settings.system.flakePath}#workstation'
            sudo nixos-rebuild boot --flake /home/${settings.account.name}/${settings.system.flakePath}#workstation
          '')

          (writeShellScriptBin "nixts" ''
            echo '# sudo nice -1 nixos-rebuild test --flake /home/${settings.account.name}/${settings.system.flakePath}#workstation'
            sudo nixos-rebuild test --flake /home/${settings.account.name}/${settings.system.flakePath}#workstation
          '')

          (writeShellScriptBin "nixdr" ''
            echo '# sudo nice -1 nixos-rebuild dry-run --flake /home/${settings.account.name}/${settings.system.flakePath}#workstation'
            sudo nixos-rebuild dry-run --flake /home/${settings.account.name}/${settings.system.flakePath}#workstation
          '')

          (writeShellScriptBin "nixrl" ''
            echo '# sudo nice -1 nixos-rebuild switch --flake /home/${settings.account.name}/${settings.system.flakePath}#workstation --rollback'
            sudo nixos-rebuild switch --flake /home/${settings.account.name}/${settings.system.flakePath}#workstation --rollback
          '')

          (writeShellScriptBin "nixup" ''
            echo '# nix flake update --flake /home/${settings.account.name}/${settings.system.flakePath}'
            nix flake update --flake /home/${settings.account.name}/${settings.system.flakePath}
          '')

          (writeShellScriptBin "nixar" ''
            echo '# nix flake archive /home/${settings.account.name}/${settings.system.flakePath}'
            nix flake archive /home/${settings.account.name}/${settings.system.flakePath}
          '')

          (writeShellScriptBin "nixtr" ''
            echo '# journalctl -xe --unit home-manager-${settings.account.name}'
            journalctl -xe --unit home-manager-${settings.account.name}
          '')

          (writeShellScriptBin "nixim" ''
            echo '# sudo nice -1 nixos-rebuild build-image --flake /home/${settings.account.name}/${settings.system.flakePath}#image --image-variant iso'
            sudo nice -1 nixos-rebuild build-image --flake /home/${settings.account.name}/${settings.system.flakePath}#image --image-variant iso
          '')

          (writeShellScriptBin "nixgc" ''
            echo '# sudo nix-collect-garbage --delete-older-than 30d'
            sudo nix-collect-garbage --delete-older-than 30d
            echo '# nix-collect-garbage --delete-older-than 30d'
            nix-collect-garbage --delete-older-than 30d
          '')

          (writeShellScriptBin "nixca" ''
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
            echo '# sudo nix-env --list-generations --profile /nix/var/nix/profiles/system'
            sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
          '')

          (writeShellScriptBin "nixpk" ''
            if [ $# -ne 1 ]; then
              echo "Usage: nixpk <package>"
              exit 1
            fi
            dir=$(nix-build "${pkgs.path}" -A "$1" --no-out-link) || exit 1
            cd "$dir" && exec $SHELL
          '')
        ];
      })

      (lib.mkIf (settings.profile == "image") {
        home.packages = with pkgs; [

          (writeShellScriptBin "nixgu" ''
            echo "nixsw | Switch configuration"
            echo "nixup | Upgrade system"
            echo "nixdr | Dry run"
            echo "nixts | Test build"
            echo "nixbo | Boot loader"
            echo "nixrl | Rollback"
            echo "nixgc | Garbage collect"
            echo "nixca | Collect all"
            echo "nixop | Optimise system"
            echo "nixar | Archive system"
            echo "nixtr | Troubleshoot"
            echo "nixls | List generations"
            echo "nixpk | Enter package"
          '')

          (writeShellScriptBin "nixsw" ''
            echo '# sudo nixos-rebuild switch --flake /home/${settings.account.name}/${settings.system.flakePath}#image'
            sudo nixos-rebuild switch --flake /home/${settings.account.name}/${settings.system.flakePath}#image
          '')

          (writeShellScriptBin "nixbo" ''
            echo '# sudo nixos-rebuild boot --flake /home/${settings.account.name}/${settings.system.flakePath}#image'
            sudo nixos-rebuild boot --flake /home/${settings.account.name}/${settings.system.flakePath}#image
          '')

          (writeShellScriptBin "nixts" ''
            echo '# sudo nixos-rebuild test --flake /home/${settings.account.name}/${settings.system.flakePath}#image'
            sudo nixos-rebuild test --flake /home/${settings.account.name}/${settings.system.flakePath}#image
          '')

          (writeShellScriptBin "nixdr" ''
            echo '# sudo nixos-rebuild dry-run --flake /home/${settings.account.name}/${settings.system.flakePath}#image'
            sudo nixos-rebuild dry-run --flake /home/${settings.account.name}/${settings.system.flakePath}#image
          '')

          (writeShellScriptBin "nixrl" ''
            echo '# sudo nixos-rebuild switch --flake /home/${settings.account.name}/${settings.system.flakePath}#image --rollback'
            sudo nixos-rebuild switch --flake /home/${settings.account.name}/${settings.system.flakePath}#image --rollback
          '')

          (writeShellScriptBin "nixup" ''
            echo '# nix flake update --flake /home/${settings.account.name}/${settings.system.flakePath}'
            nix flake update --flake /home/${settings.account.name}/${settings.system.flakePath}
          '')

          (writeShellScriptBin "nixar" ''
            echo '# nix flake archive /home/${settings.account.name}/${settings.system.flakePath}'
            nix flake archive /home/${settings.account.name}/${settings.system.flakePath}
          '')

          (writeShellScriptBin "nixtr" ''
            echo '# journalctl -xe --unit home-manager-${settings.account.name}'
            journalctl -xe --unit home-manager-${settings.account.name}
          '')

          (writeShellScriptBin "nixgc" ''
            echo '# sudo nix-collect-garbage'
            sudo nix-collect-garbage
            echo '# nix-collect-garbage'
            nix-collect-garbage
          '')

          (writeShellScriptBin "nixca" ''
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
            echo '# sudo nix-env --list-generations --profile /nix/var/nix/profiles/system'
            sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
          '')

          (writeShellScriptBin "nixpk" ''
            if [ $# -ne 1 ]; then
              echo "Usage: nixpk <package>"
              exit 1
            fi
            dir=$(nix-build "${pkgs.path}" -A "$1" --no-out-link) || exit 1
            cd "$dir" && exec $SHELL
          '')
        ];
      })

      (lib.mkIf (settings.profile == "windows-subsystem") {
        home.packages = with pkgs; [

          (writeShellScriptBin "nixgu" ''
            echo "nixsw | Switch configuration"
            echo "nixup | Upgrade system"
            echo "nixdr | Dry run"
            echo "nixts | Test build"
            echo "nixbo | Boot loader"
            echo "nixrl | Rollback"
            echo "nixgc | Garbage collect"
            echo "nixca | Collect all"
            echo "nixop | Optimise system"
            echo "nixar | Archive system"
            echo "nixtr | Troubleshoot"
            echo "nixrs | Restart nix-daemon"
            echo "nixls | List generations"
            echo "nixim | Build Image"
            echo "nixpk | Enter package"
          '')

          (writeShellScriptBin "nixsw" ''
            echo '# sudo nixos-rebuild switch --flake /home/${settings.account.name}/${settings.system.flakePath}#windows-subsystem'
            sudo nixos-rebuild switch --flake /home/${settings.account.name}/${settings.system.flakePath}#windows-subsystem
          '')

          (writeShellScriptBin "nixbo" ''
            echo '# sudo nixos-rebuild boot --flake /home/${settings.account.name}/${settings.system.flakePath}#windows-subsystem'
            sudo nixos-rebuild boot --flake /home/${settings.account.name}/${settings.system.flakePath}#windows-subsystem
          '')

          (writeShellScriptBin "nixts" ''
            echo '# sudo nixos-rebuild test --flake /home/${settings.account.name}/${settings.system.flakePath}#windows-subsystem'
            sudo nixos-rebuild test --flake /home/${settings.account.name}/${settings.system.flakePath}#windows-subsystem
          '')

          (writeShellScriptBin "nixdr" ''
            echo '# sudo nixos-rebuild dry-run --flake /home/${settings.account.name}/${settings.system.flakePath}#windows-subsystem'
            sudo nixos-rebuild dry-run --flake /home/${settings.account.name}/${settings.system.flakePath}#windows-subsystem
          '')

          (writeShellScriptBin "nixrl" ''
            echo '# sudo nixos-rebuild switch --flake /home/${settings.account.name}/${settings.system.flakePath}#windows-subsystem --rollback'
            sudo nixos-rebuild switch --flake /home/${settings.account.name}/${settings.system.flakePath}#windows-subsystem --rollback
          '')

          (writeShellScriptBin "nixup" ''
            echo '# nix flake update --flake /home/${settings.account.name}/${settings.system.flakePath}'
            nix flake update --flake /home/${settings.account.name}/${settings.system.flakePath}
          '')

          (writeShellScriptBin "nixar" ''
            echo '# nix flake archive /home/${settings.account.name}/${settings.system.flakePath}'
            nix flake archive /home/${settings.account.name}/${settings.system.flakePath}
          '')

          (writeShellScriptBin "nixtr" ''
            echo '# journalctl -xe --unit home-manager-${settings.account.name}'
            journalctl -xe --unit home-manager-${settings.account.name}
          '')

          (writeShellScriptBin "nixim" ''
            echo '# sudo nice -1 nixos-rebuild  build-image --flake /home/${settings.account.name}/${settings.system.flakePath}#image --image-variant iso'
            sudo nice -1 nixos-rebuild  build-image --flake /home/${settings.account.name}/${settings.system.flakePath}#image --image-variant iso
          '')

          (writeShellScriptBin "nixgc" ''
            echo '# sudo nix-collect-garbage --delete-older-than 30d'
            sudo nix-collect-garbage --delete-older-than 30d
            echo '# nix-collect-garbage --delete-older-than 30d'
            nix-collect-garbage --delete-older-than 30d
          '')

          (writeShellScriptBin "nixca" ''
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
            echo '# sudo nix-env --list-generations --profile /nix/var/nix/profiles/system'
            sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
          '')

          (writeShellScriptBin "nixpk" ''
            if [ $# -ne 1 ]; then
              echo "Usage: nixpk <package>"
              exit 1
            fi
            dir=$(nix-build "${pkgs.path}" -A "$1" --no-out-link) || exit 1
            cd "$dir" && exec $SHELL
          '')
        ];
      })

      (lib.mkIf (settings.profile == "server") {
        home.packages = with pkgs; [

          (writeShellScriptBin "nixgu" ''
            echo "nixsw | Switch configuration"
            echo "nixup | Upgrade system"
            echo "nixdr | Dry run"
            echo "nixts | Test build"
            echo "nixbo | Boot loader"
            echo "nixrl | Rollback"
            echo "nixgc | Garbage collect"
            echo "nixca | Collect all"
            echo "nixop | Optimise system"
            echo "nixar | Archive system"
            echo "nixtr | Troubleshoot"
            echo "nixls | List generations"
          '')

          (writeShellScriptBin "nixsw" ''
            echo '# sudo nixos-rebuild switch --flake /home/${settings.account.name}/${settings.system.flakePath}#server'
            sudo nixos-rebuild switch --flake /home/${settings.account.name}/${settings.system.flakePath}#server
          '')

          (writeShellScriptBin "nixbo" ''
            echo '# sudo nixos-rebuild boot --flake /home/${settings.account.name}/${settings.system.flakePath}#server'
            sudo nixos-rebuild boot --flake /home/${settings.account.name}/${settings.system.flakePath}#server
          '')

          (writeShellScriptBin "nixts" ''
            echo '# sudo nixos-rebuild test --flake /home/${settings.account.name}/${settings.system.flakePath}#server'
            sudo nixos-rebuild test --flake /home/${settings.account.name}/${settings.system.flakePath}#server
          '')

          (writeShellScriptBin "nixdr" ''
            echo '# sudo nixos-rebuild dry-run --flake /home/${settings.account.name}/${settings.system.flakePath}#server'
            sudo nixos-rebuild dry-run --flake /home/${settings.account.name}/${settings.system.flakePath}#server
          '')

          (writeShellScriptBin "nixrl" ''
            echo '# sudo nixos-rebuild switch --flake /home/${settings.account.name}/${settings.system.flakePath}#server --rollback'
            sudo nixos-rebuild switch --flake /home/${settings.account.name}/${settings.system.flakePath}#server --rollback
          '')

          (writeShellScriptBin "nixup" ''
            echo '# sudo nix flake update --flake /home/${settings.account.name}/${settings.system.flakePath}'
            sudo nix flake update --flake /home/${settings.account.name}/${settings.system.flakePath}
            echo '# sudo nixos-rebuild switch --flake /home/${settings.account.name}/${settings.system.flakePath}#server'
            sudo nixos-rebuild switch --flake /home/${settings.account.name}/${settings.system.flakePath}#server
          '')

          (writeShellScriptBin "nixar" ''
            echo '# nix flake archive /home/${settings.account.name}/${settings.system.flakePath}'
            nix flake archive /home/${settings.account.name}/${settings.system.flakePath}
          '')

          (writeShellScriptBin "nixtr" ''
            echo '# journalctl -xe --unit home-manager-${settings.account.name}'
            journalctl -xe --unit home-manager-${settings.account.name}
          '')

          (writeShellScriptBin "nixgc" ''
            echo '# sudo nix-collect-garbage'
            sudo nix-collect-garbage
            echo '# nix-collect-garbage'
            nix-collect-garbage
          '')

          (writeShellScriptBin "nixca" ''
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
            echo '# sudo nix-env --list-generations --profile /nix/var/nix/profiles/system'
            sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
          '')
        ];
      })

      (lib.mkIf (settings.profile == "darwin") {})

      (lib.mkIf (settings.profile == "virtual-machine") {
        home.packages = with pkgs; [

          (writeShellScriptBin "nixgu" ''
            echo "nixsw | Switch configuration"
            echo "nixup | Upgrade system"
            echo "nixdr | Dry run"
            echo "nixts | Test build"
            echo "nixbo | Boot loader"
            echo "nixrl | Rollback"
            echo "nixgc | Garbage collect"
            echo "nixca | Collect all"
            echo "nixop | Optimise system"
            echo "nixar | Archive system"
            echo "nixtr | Troubleshoot"
            echo "nixrs | Restart nix-daemon"
            echo "nixls | List generations"
            echo "nixim | Build Image"
            echo "nixpk | Enter package"
          '')

          (writeShellScriptBin "nixsw" ''
            echo '# sudo nixos-rebuild switch --flake /home/${settings.account.name}/${settings.system.flakePath}#virtual-machine'
            sudo nixos-rebuild switch --flake /home/${settings.account.name}/${settings.system.flakePath}#virtual-machine
          '')

          (writeShellScriptBin "nixbo" ''
            echo '# sudo nixos-rebuild boot --flake /home/${settings.account.name}/${settings.system.flakePath}#virtual-machine'
            sudo nixos-rebuild boot --flake /home/${settings.account.name}/${settings.system.flakePath}#virtual-machine
          '')

          (writeShellScriptBin "nixts" ''
            echo '# sudo nixos-rebuild test --flake /home/${settings.account.name}/${settings.system.flakePath}#virtual-machine'
            sudo nixos-rebuild test --flake /home/${settings.account.name}/${settings.system.flakePath}#virtual-machine
          '')

          (writeShellScriptBin "nixdr" ''
            echo '# sudo nixos-rebuild dry-run --flake /home/${settings.account.name}/${settings.system.flakePath}#virtual-machine'
            sudo nixos-rebuild dry-run --flake /home/${settings.account.name}/${settings.system.flakePath}#virtual-machine
          '')

          (writeShellScriptBin "nixrl" ''
            echo '# sudo nixos-rebuild switch --flake /home/${settings.account.name}/${settings.system.flakePath}#virtual-machine --rollback'
            sudo nixos-rebuild switch --flake /home/${settings.account.name}/${settings.system.flakePath}#virtual-machine --rollback
          '')

          (writeShellScriptBin "nixup" ''
            echo '# nix flake update --flake /home/${settings.account.name}/${settings.system.flakePath}'
            nix flake update --flake /home/${settings.account.name}/${settings.system.flakePath}
          '')

          (writeShellScriptBin "nixar" ''
            echo '# nix flake archive /home/${settings.account.name}/${settings.system.flakePath}'
            nix flake archive /home/${settings.account.name}/${settings.system.flakePath}
          '')

          (writeShellScriptBin "nixtr" ''
            echo '# journalctl -xe --unit home-manager-${settings.account.name}'
            journalctl -xe --unit home-manager-${settings.account.name}
          '')

          (writeShellScriptBin "nixim" ''
            echo '# sudo nice -1 nixos-rebuild  build-image --flake /home/${settings.account.name}/${settings.system.flakePath}#image --image-variant iso'
            sudo nice -1 nixos-rebuild  build-image --flake /home/${settings.account.name}/${settings.system.flakePath}#image --image-variant iso
          '')

          (writeShellScriptBin "nixgc" ''
            echo '# sudo nix-collect-garbage --delete-older-than 30d'
            sudo nix-collect-garbage --delete-older-than 30d
            echo '# nix-collect-garbage --delete-older-than 30d'
            nix-collect-garbage --delete-older-than 30d
          '')

          (writeShellScriptBin "nixca" ''
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
            echo '# sudo nix-env --list-generations --profile /nix/var/nix/profiles/system'
            sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
          '')

          (writeShellScriptBin "nixpk" ''
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

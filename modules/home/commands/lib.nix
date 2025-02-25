{ lib, pkgs, settings, ... }: let

  profiles = {

    apple = {
      # NixPro-Apple specific configuration.
    };

    image = {
      # NixPro-Image specific configuration.
      home.packages = with pkgs; [
        (writeShellScriptBin "nixgu" '' # Nix Guide.
    	  echo "nixsw | Switch configuration"
	      echo "nixup | Upgrade system"
    	  echo "nixdr | Dry run"
	      echo "nixts | Test build"
    	  echo "nixbo | Boot loader"
	      echo "nixrl | Rollback"
    	  echo "nixgx | Garbage collect"
	      echo "nixop | Optimise system"
       	echo "nixar | Archive system"
    	  echo "nixtr | Troubleshoot"
	      echo "nixls | List generations"
        echo "nixpk | Enter package"
        '')
        (writeShellScriptBin "nixsw" '' # Rebuild Switch.
          echo '# sudo nixos-rebuild --upgrade switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
          sudo nixos-rebuild --upgrade switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}
        '')
        (writeShellScriptBin "nixbo" '' # Rebuild Boot.
          echo '# sudo nixos-rebuild test --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
          sudo nixos-rebuild test --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}
        '')
        (writeShellScriptBin "nixts" '' # Rebuild Test.
          echo '# sudo nixos-rebuild test --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
          sudo nixos-rebuild test --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}
        '')
        (writeShellScriptBin "nixdr" '' # Nix Dry-Activate.
          echo '# sudo nixos-rebuild dry-run --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
          sudo nixos-rebuild dry-run --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}
        '')
        (writeShellScriptBin "nixrl" '' # Rebuild Rollback.
          echo '# sudo nixos-rebuild switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name} --rollback'
          sudo nixos-rebuild switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name} --rollback
        '')
        (writeShellScriptBin "nixup" '' # Update Flake.
          echo '# nix flake update --flake /home/${settings.user.name}/${settings.system.flakePath}'
          nix flake update --flake /home/${settings.user.name}/${settings.system.flakePath}
        '')
        (writeShellScriptBin "nixar" '' # Nix Archive.
          echo '# nix flake archive /home/${settings.user.name}/${settings.system.flakePath}'
          nix flake archive /home/${settings.user.name}/${settings.system.flakePath}
        '')
        (writeShellScriptBin "nixtr" '' # Nix Troubleshoot.
          echo '# journalctl -xe --unit home-manager-${settings.user.name}'
          journalctl -xe --unit home-manager-${settings.user.name}
        '')
        (writeShellScriptBin "nixgc" '' # Nix Garbage collect.
          echo '# sudo nix-collect-garbage'
          sudo nix-collect-garbage
          echo '# nix-collect-garbage'
          nix-collect-garbage
        '')
        (writeShellScriptBin "nixop" '' # Nix Optimise.
          echo '# sudo nix-store --optimise'
          sudo nix-store --optimise
          echo '# nix-store --optimise'
          nix-store --optimise
        '')
        (writeShellScriptBin "nixls" '' # Nix List generations.
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
    };

    microsoft = {
      # NixPro-WSL specific configuration.
      home.packages = with pkgs; [
        (writeShellScriptBin "nixgu" '' # Nix Guide.
    	  echo "nixsw | Switch configuration"
	      echo "nixup | Upgrade system"
    	  echo "nixdr | Dry run"
	      echo "nixts | Test build"
    	  echo "nixbo | Boot loader"
	      echo "nixrl | Rollback"
    	  echo "nixgx | Garbage collect"
	      echo "nixop | Optimise system"
       	echo "nixar | Archive system"
    	  echo "nixtr | Troubleshoot"
	      echo "nixrs | Restart nix-deamon"
        echo "nixls | List generations"
        echo "nixim | Build Image"
        echo "nixpk | Enter package"
        '')
        (writeShellScriptBin "nixsw" '' # Rebuild Switch.
          echo '# sudo nixos-rebuild --upgrade switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
          sudo nixos-rebuild --upgrade switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}
        '')
        (writeShellScriptBin "nixbo" '' # Rebuild Boot.
          echo '# sudo nixos-rebuild test --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
          sudo nixos-rebuild test --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}
        '')
        (writeShellScriptBin "nixts" '' # Rebuild Test.
          echo '# sudo nixos-rebuild test --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
          sudo nixos-rebuild test --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}
        '')
        (writeShellScriptBin "nixdr" '' # Nix Dry-Activate.
          echo '# sudo nixos-rebuild dry-run --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
          sudo nixos-rebuild dry-run --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}
        '')
        (writeShellScriptBin "nixrl" '' # Rebuild Rollback.
          echo '# sudo nixos-rebuild switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name} --rollback'
          sudo nixos-rebuild switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name} --rollback
        '')
        (writeShellScriptBin "nixup" '' # Update Flake.
          echo '# nix flake update --flake /home/${settings.user.name}/${settings.system.flakePath}'
          nix flake update --flake /home/${settings.user.name}/${settings.system.flakePath}
        '')
        (writeShellScriptBin "nixar" '' # Nix Archive.
          echo '# nix flake archive /home/${settings.user.name}/${settings.system.flakePath}'
          nix flake archive /home/${settings.user.name}/${settings.system.flakePath}
        '')
        (writeShellScriptBin "nixtr" '' # Nix Troubleshoot.
          echo '# journalctl -xe --unit home-manager-${settings.user.name}'
          journalctl -xe --unit home-manager-${settings.user.name}
        '')
        (writeShellScriptBin "nixim" '' # Build Image.
          echo '# nix build /home/${settings.user.name}/${settings.system.flakePath}#nixosConfigurations.${settings.user.name}.config.system.build.isoImage --impure'
          nix build /home/${settings.user.name}/${settings.system.flakePath}#nixosConfigurations.${settings.user.name}.config.system.build.isoImage --impure
        '')
        (writeShellScriptBin "nixgc" '' # Nix Garbage collect.
          echo '# sudo nix-collect-garbage --delete-older-than 30d'
          sudo nix-collect-garbage --delete-older-than 30d
          echo '# nix-collect-garbage --delete-older-than 30d'
          nix-collect-garbage --delete-older-than 30d
        '')
        (writeShellScriptBin "nixop" '' # Nix Optimise.
          echo '# sudo nix-store --optimise'
          sudo nix-store --optimise
          echo '# nix-store --optimise'
          nix-store --optimise
        '')
        (writeShellScriptBin "nixrs" '' # Restart nix-deamon.
          echo '# sudo systemctl restart nix-daemon'
          sudo systemctl restart nix-daemon
        '')
        (writeShellScriptBin "nixls" '' # Nix List generations.
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
    };

    server = {
      # NixPro-Server specific configuration.
      home.packages = with pkgs; [
        (writeShellScriptBin "nixgu" '' # Nix Guide.
    	  echo "nixsw | Switch configuration"
	      echo "nixup | Upgrade system"
    	  echo "nixdr | Dry run"
	      echo "nixts | Test build"
    	  echo "nixbo | Boot loader"
	      echo "nixrl | Rollback"
    	  echo "nixgx | Garbage collect"
	      echo "nixop | Optimise system"
       	echo "nixar | Archive system"
    	  echo "nixtr | Troubleshoot"
	      echo "nixls | List generations"
        '')
        (writeShellScriptBin "nixsw" '' # Rebuild Switch.
          echo '# sudo nixos-rebuild --upgrade switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
          sudo nixos-rebuild --upgrade switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}
        '')
        (writeShellScriptBin "nixbo" '' # Rebuild Boot.
          echo '# sudo nixos-rebuild test --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
          sudo nixos-rebuild test --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}
        '')
        (writeShellScriptBin "nixts" '' # Rebuild Test.
          echo '# sudo nixos-rebuild test --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
          sudo nixos-rebuild test --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}
        '')
        (writeShellScriptBin "nixdr" '' # Nix Dry-Activate.
          echo '# sudo nixos-rebuild dry-run --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
          sudo nixos-rebuild dry-run --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}
        '')
        (writeShellScriptBin "nixrl" '' # Rebuild Rollback.
          echo '# sudo nixos-rebuild switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name} --rollback'
          sudo nixos-rebuild switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name} --rollback
        '')
        (writeShellScriptBin "nixup" '' # Rebuild Update.
        echo '# sudo nix flake update --flake /home/${settings.user.name}/${settings.system.flakePath}'
          sudo nix flake update --flake /home/${settings.user.name}/${settings.system.flakePath}
        echo '# sudo nixos-rebuild --upgrade switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
          sudo nixos-rebuild --upgrade switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}
        '')
        (writeShellScriptBin "nixar" '' # Nix Archive.
          echo '# nix flake archive /home/${settings.user.name}/${settings.system.flakePath}'
          nix flake archive /home/${settings.user.name}/${settings.system.flakePath}
        '')
        (writeShellScriptBin "nixtr" '' # Nix Troubleshoot.
          echo '# journalctl -xe --unit home-manager-${settings.user.name}'
          journalctl -xe --unit home-manager-${settings.user.name}
        '')
        (writeShellScriptBin "nixim" '' # Build Image.
          echo '# nix build /home/${settings.user.name}/${settings.system.flakePath}#nixosConfigurations.${settings.user.name}.config.system.build.isoImage --impure'
          nix build /home/${settings.user.name}/${settings.system.flakePath}#nixosConfigurations.${settings.user.name}.config.system.build.isoImage --impure
        '')
        (writeShellScriptBin "nixgc" '' # Nix Garbage collect.
          echo '# sudo nix-collect-garbage'
          sudo nix-collect-garbage
          echo '# nix-collect-garbage'
          nix-collect-garbage
        '')
        (writeShellScriptBin "nixop" '' # Nix Optimise.
          echo '# sudo nix-store --optimise'
          sudo nix-store --optimise
          echo '# nix-store --optimise'
          nix-store --optimise
        '')
        (writeShellScriptBin "nixrs" '' # Restart nix-deamon.
          echo '# sudo systemctl restart nix-daemon'
          sudo systemctl restart nix-daemon
        '')
        (writeShellScriptBin "nixls" '' # Nix List generations.
          echo '# sudo nix-env --list-generations --profile /nix/var/nix/profiles/system | wc -l'
          sudo nix-env --list-generations --profile /nix/var/nix/profiles/system | wc -l
        '')
       ];
    };

    standalone = {
      # NixPro specific configuration.
      home.packages = with pkgs; [
        (writeShellScriptBin "nixgu" '' # Nix Guide.
    	  echo "nixsw | Switch configuration"
	      echo "nixup | Upgrade system"
    	  echo "nixdr | Dry run"
	      echo "nixts | Test build"
    	  echo "nixbo | Boot loader"
	      echo "nixrl | Rollback"
    	  echo "nixgx | Garbage collect"
	      echo "nixop | Optimise system"
       	echo "nixar | Archive system"
    	  echo "nixtr | Troubleshoot"
	      echo "nixrs | Restart nix-deamon"
        echo "nixls | List generations"
        echo "nixim | Build Image"
        echo "nixpk | Enter package"
        '')
        (writeShellScriptBin "nixsw" '' # Rebuild Switch.
          echo '# sudo nixos-rebuild --upgrade switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
          sudo nixos-rebuild --upgrade switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}
        '')
        (writeShellScriptBin "nixbo" '' # Rebuild Boot.
          echo '# sudo nixos-rebuild test --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
          sudo nixos-rebuild test --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}
        '')
        (writeShellScriptBin "nixts" '' # Rebuild Test.
          echo '# sudo nixos-rebuild test --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
          sudo nixos-rebuild test --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}
        '')
        (writeShellScriptBin "nixdr" '' # Nix Dry-Activate.
          echo '# sudo nixos-rebuild dry-run --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
          sudo nixos-rebuild dry-run --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}
        '')
        (writeShellScriptBin "nixrl" '' # Rebuild Rollback.
          echo '# sudo nixos-rebuild switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name} --rollback'
          sudo nixos-rebuild switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name} --rollback
        '')
        (writeShellScriptBin "nixup" '' # Update Flake.
          echo '# nix flake update --flake /home/${settings.user.name}/${settings.system.flakePath}'
          nix flake update --flake /home/${settings.user.name}/${settings.system.flakePath}
        '')
        (writeShellScriptBin "nixar" '' # Nix Archive.
          echo '# nix flake archive /home/${settings.user.name}/${settings.system.flakePath}'
          nix flake archive /home/${settings.user.name}/${settings.system.flakePath}
        '')
        (writeShellScriptBin "nixtr" '' # Nix Troubleshoot.
          echo '# journalctl -xe --unit home-manager-${settings.user.name}'
          journalctl -xe --unit home-manager-${settings.user.name}
        '')
        (writeShellScriptBin "nixim" '' # Build Image.
          echo '# nix build /home/${settings.user.name}/${settings.system.flakePath}#nixosConfigurations.${settings.user.name}.config.system.build.isoImage --impure'
          nix build /home/${settings.user.name}/${settings.system.flakePath}#nixosConfigurations.${settings.user.name}.config.system.build.isoImage --impure
        '')
        (writeShellScriptBin "nixgc" '' # Nix Garbage collect.
          echo '# sudo nix-collect-garbage --delete-older-than 30d'
          sudo nix-collect-garbage --delete-older-than 30d
          echo '# nix-collect-garbage --delete-older-than 30d'
          nix-collect-garbage --delete-older-than 30d
        '')
        (writeShellScriptBin "nixop" '' # Nix Optimise.
          echo '# sudo nix-store --optimise'
          sudo nix-store --optimise
          echo '# nix-store --optimise'
          nix-store --optimise
        '')
        (writeShellScriptBin "nixrs" '' # Restart nix-deamon.
          echo '# sudo systemctl restart nix-daemon'
          sudo systemctl restart nix-daemon
        '')
        (writeShellScriptBin "nixls" '' # Nix List generations.
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
    };

    virtual-machine = {
      # NixPro-VM specific configuration.
    };
  };
in {
  options.settings.profile = lib.mkOption {
    type = lib.types.enum (builtins.attrNames profiles);
    default = "standalone";
    description = "System configuration profile";
  };
  config = lib.mkMerge [
    # base configuration. (common to all profiles)
    {
    }
    # profile-specific overrides.
    (lib.mkIf (builtins.hasAttr settings.profile profiles)
      (builtins.getAttr settings.profile profiles))
  ];
}

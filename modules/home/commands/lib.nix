{ config, lib, pkgs, settings, ... }: let  

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
          echo '# nix flake update /home/${settings.user.name}/${settings.system.flakePath}'
          nix flake update /home/${settings.user.name}/${settings.system.flakePath}
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
          echo '# nix flake update /home/${settings.user.name}/${settings.system.flakePath}'
          nix flake update /home/${settings.user.name}/${settings.system.flakePath}
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
        echo '# sudo nix flake update /home/${settings.user.name}/${settings.system.flakePath}'
          sudo nix flake update /home/${settings.user.name}/${settings.system.flakePath}
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
      wayland.windowManager.hyprland.settings.bind = [ "SUPER,L,exec,nixmu" ];
      
      home.packages = with pkgs; [ 
        (writeShellScriptBin "libpro" ''
          # Store the start time and first notification
          timer_start() {
            export _lib_timer_start=$(date +%s)
            notify-send -t 5000 "$1"
          }

          # Run the command and track its success/failure
          timer_run() {
            # Store the command to run
            local cmd="$1"
            # Run the command and store its exit code
            eval "$cmd"
            export _lib_timer_exit_code=$?
            return $_lib_timer_exit_code
          }

          # Handle the final notification with success/failure status
          timer_end() {
            local success_msg="$1"
            local failure_msg="$2"
            local end_time=$(date +%s)
            local duration=$((end_time - _lib_timer_start))

            # Format duration
            local hours=$((duration / 3600))
            local minutes=$(( (duration % 3600) / 60 ))
            local seconds=$((duration % 60))

            # Build the time string
            local time_string=""
            if [ $hours -gt 0 ]; then
              if [ $hours -eq 1 ]; then
                time_string+="1 Hour"
              else
                time_string+="$hours Hours"
              fi
              # If there are minutes, add them
              if [ $minutes -gt 0 ]; then
                if [ $minutes -eq 1 ]; then
            time_string+=" 1 Minute"
                else
            time_string+=" $minutes Minutes"
                fi
              fi
            elif [ $minutes -gt 0 ]; then
              if [ $minutes -eq 1 ]; then
                time_string+="1 Minute"
              else
                time_string+="$minutes Minutes"
              fi
            else
              if [ $seconds -eq 1 ]; then
                time_string+="1 Second"
              else
                time_string+="$seconds Seconds"
              fi
            fi

            # Show appropriate notification based on exit code
            if [ "$_lib_timer_exit_code" -eq 0 ]; then
              notify-send -t 5000 "$success_msg in ''${time_string}"
            else
              notify-send -t 5000 "$failure_msg in ''${time_string}"
            fi

            # Return the original exit code
            return $_lib_timer_exit_code
          }
        '')
        (writeShellScriptBin "nixsw" '' # Nix Switch. # nixsw doesn't work on WSL and should not be used until debugged. 
            . libpro
            timer_start "🛠️ NixOS: Build Starting..."
            echo '# sudo nixos-rebuild --upgrade switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
            timer_run 'sudo nixos-rebuild --upgrade switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name} |& nom'
            timer_end "✅ NixOS: Build Completed" "❌ NixOS: Build Failed"
        '')
        (writeShellScriptBin "nixdr" '' # Nix Dry-run.
          . libpro
          timer_start "🔍 NixOS: Dry-run Starting..."
          echo '# sudo nixos-rebuild dry-run --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
          timer_run 'sudo nixos-rebuild dry-run --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
          timer_end "✅ NixOS: Dry-run Completed" "❌ NixOS: Dry-run Failed"
        '')
        (writeShellScriptBin "nixts" '' # Nix Test.
          . libpro
          timer_start "🧪 NixOS: Test Starting..."
          echo '# sudo nixos-rebuild test --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
          timer_run 'sudo nixos-rebuild test --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
          timer_end "✅ NixOS: Test Activation" "❌ NixOS: Test Failed to build"
        '')
        (writeShellScriptBin "nixbo" '' # Nix Boot.
          . libpro
          timer_start "⚙️ NixOS: Building Boot..."
          echo '# sudo nixos-rebuild boot --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
          timer_run 'sudo nixos-rebuild boot --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name}'
          timer_end "✅ NixOS: Boot Build Completed" "❌ NixOS: Boot Failed to build"
        '')
        (writeShellScriptBin "nixrl" '' # Nix Rollback.
          . libpro
          timer_start "⏮️ NixOS: Rollback Starting..."
          echo '# sudo nixos-rebuild switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name} --rollback'
          timer_run 'sudo nixos-rebuild switch --flake /home/${settings.user.name}/${settings.system.flakePath}#${settings.user.name} --rollback'
          timer_end "✅ NixOS: Rollback Completed" "❌ NixOS: Rollback Failed"
        '')
        (writeShellScriptBin "nixgc" '' # Nix Garbage collect.
          . libpro
          timer_start "🗑️ NixOS: Garbage Collection Starting..."
          echo '# sudo nix-collect-garbage --delete-older-than 30d'
          timer_run 'sudo nix-collect-garbage --delete-older-than 30d'
          echo '# nix-collect-garbage --delete-older-than 30d'
          timer_run 'nix-collect-garbage --delete-older-than 30d'
          echo '# sudo nix-store --optimise'
          timer_run 'sudo nix-store --optimise'
          echo '# nix-store --optimise'
          timer_run 'nix-store --optimise'
          timer_end "✅ NixOS: Garbage Collection Completed" "❌ NixOS: Garbage Collection Failed"
        '')
        (writeShellScriptBin "nixup" '' # Nix Update flake.
            . libpro
            timer_start "⬆️ NixOS: Flake Update Starting..."
            echo '# sudo nix flake update --flake /home/${settings.user.name}/${settings.system.flakePath}'
            timer_run 'sudo nix flake update --flake /home/${settings.user.name}/${settings.system.flakePath}'
            timer_end "✅ NixOS: Flake Update Completed" "❌ NixOS: Flake Update Failed"
        '')
        (writeShellScriptBin "nixar" '' # Nix Flake Archive.
            . libpro
            timer_start "📁 NixOS: Flake Archive starting..."
            echo '# nix flake archive /home/${settings.user.name}/${settings.system.flakePath}'
            timer_run 'nix flake archive /home/${settings.user.name}/${settings.system.flakePath}'
            timer_end "✅ NixOS: Flake Archive Completed"
        '')
        (writeShellScriptBin "nixtr" '' # Nix Troubleshoot.
            . libpro
            timer_start "🔧 NixOS: Troubleshoot Starting..."
            echo '# journalctl -xe --unit home-manager-${settings.user.name}'
            timer_run 'journalctl -xe --unit home-manager-${settings.user.name}'
            timer_end "✅ NixOS: Home-Manager Log Generated" "❌ NixOS: Troubleshooting Failed"
        '')
        (writeShellScriptBin "nixls" '' # Nix List generations.
            num=$(sudo nix-env --list-generations --profile /nix/var/nix/profiles/system | wc -l)
            word="Generations"
            [ "$num" -eq 1 ] && word="Generation"
            notify-send -t 5000 "NixOS: $num $word Available"
        '')
        (writeShellScriptBin "nixmu" '' # Nix Menu Actions.
          echo -e "\
Switch configuration
Update system
Dry run
Test build
Boot loader
Rollback
Garbage collect
Archive system
Troubleshoot
List generations" | rofi -dmenu -i | xargs -I {} sh -c "
          case \"{}\" in
            'Switch configuration') nixsw ;;
            'Update system') nixup ;;
            'Dry run') nixdr ;;
            'Test build') nixts ;;
            'Boot loader') nixbo ;;
            'Rollback') nixrl ;;
            'Garbage collect') nixgc ;;
            'Archive system') nixar ;;
            'Troubleshoot') nixtr ;;
            'List generations') nixls ;;
          esac"
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
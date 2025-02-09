![20250209_07h26m10s_grim](https://github.com/user-attachments/assets/ae88eaf3-4a37-4be4-8e4f-5a6e35249113)
### Install command:
```
nix-shell -p git --run 'git clone https://github.com/fndov/NixPro .nixpro'
.nixpro/document/scripts/init.sh
```
### System Structure

NixPro builds your system configuration by combining modules based on your selected profile.

1. **Profile Selection**
   - Open `Flake.nix` to set your system profile & details.
   - Choose from profiles in the `Profile/` directory:
     - `Profile/Apple/`
     - `Profile/Microsoft/`
     - `Profile/Image/`
     - `Profile/Standalone/`
     - `Profile/Server/`
     - `Profile/Virtual-Machine/`
   - Each profile contains:
     - `Configuration.nix` - System settings.
     - `Home.nix` - Home directory settings.

2. **System Composition**
   - The system is comprised from settings in `Flake.nix` and the selected profile.
   - The profiles import modules sourced from:
     - `User/` - Powers WM/DE, Utilities, Apps & Shell.
     - `System/` - Powers Hardware and Security.

3. **Configuration**
   - Common changes are made through attribute sets and input contents within `Flake.nix`.
   - You can append to the system via paths like:
     - `user/software/apps/collection.nix`
     - `user/software/commands/sh.nix`
     - `user/wm/hyprland/default.nix`

4. **Documentation and Scripts**
   - The `Document/` directory contains additional information along with scripts for maintenance and setup.

### Creating your own ISO

You can produce installation media and ramfs images using the `Image/` profile and running `nixim` to build the ISO, it is automatically named based on options like
| Version | Desktop | Architecture | Image |
| :--- | :---: | :---: | :---: |
| 24.11 | hyprland | x86_64-linux | nixpro-24.11-hyprland-x86_64.iso |
| 22.05 | plasma | x86_64-linux | nixpro-22.05-plasma-x86_64.iso |
| 23.11 | sway |  x86_64-linux | nixpro-23.11-sway-x86_64.iso |

They can even be used for virtual machines or travel.

### Windows Subsystem for Linux
Simply use the `Microsoft/` profile and you will have access to all the essential utility's.
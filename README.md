![20250209_07h26m10s_grim](https://github.com/user-attachments/assets/ae88eaf3-4a37-4be4-8e4f-5a6e35249113)
### Install command:
```
nix-shell -p git
git clone https://github.com/fndov/NixPro .nixpro
chmod +x .nixpro/document/scripts/init.sh
.nixpro/document/scripts/init.sh
```
### System Structure

NixPro builds your system configuration by combining modules based on your selected profile.

1. **Profile Selection**
   - Open `Flake.nix` to set your system profile & details.
   - Choose from profiles in the `Profile/` directory:
     - `Profile/Microsoft/`
     - `Profile/Apple/`
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
     - `user\software\apps\extra.nix`
     - `user\software\commands\extra.nix`
     - `user\wm\hyprland\settings\hyprland.nix`

4. **Documentation and Scripts**
   - The `Document/` directory contains additional information and scripts for maintenance and setup.

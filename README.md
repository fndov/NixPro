![20250209_07h26m10s_grim](https://github.com/user-attachments/assets/ae88eaf3-4a37-4be4-8e4f-5a6e35249113)
#### Building an ISO
- Define your Image-specific Profile in `flake.nix`.
- Run the `nixim` tool to build the ISO image.
- The output file is automatically named based on version, desktop environment, and architecture.

| Version | Desktop  | Architecture  | Image                              |
| :------ | :------: | :-----------: | :---------------------------------: |
| 24.11   | hyprland | x86_64-linux  | nixpro-24.11-hyprland-x86_64.iso     |
| 22.05   | plasma   | x86_64-linux  | nixpro-22.05-plasma-x86_64.iso       |
| 23.11   | sway     | x86_64-linux  | nixpro-23.11-sway-x86_64.iso         |

#### Windows Subsystem for Linux
- Select the Microsoft-specific profile in `flake.nix`.
- This will automatically import the essential utilities for WSL.

---

This structure allows the system to be dynamically composed from universal, profile-specific, and desktop-specific modules, making it highly modular and easy to extend or maintain.

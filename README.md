#### NixPro - 📸 Photograph
![20250216_15h27m05s_grim](https://github.com/user-attachments/assets/ccdf0cb0-3696-4983-a2b9-12e35560baad)
---
#### File structure & composition
```
┌── flake.nix
├── compose
│   ├── home.nix
│   └── system.nix
├── profile/option
│   └── option
│       ├── home.nix
│       └── system.nix
├── desktop/option
│   └── option
│       ├── home.nix
│       └── system.nix
└── modules
```
#### Building an ISO

![Screenshot 2025-02-19 at 12-39-48 Wed 11 36 AM](https://github.com/user-attachments/assets/8056f514-e651-4cf8-97f6-b439d39f0a01)
---
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

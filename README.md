![20250209_07h26m10s_grim](https://github.com/user-attachments/assets/ae88eaf3-4a37-4be4-8e4f-5a6e35249113)

NixPro is dynamically composed by `flake.nix`, which defines your structure and imports modules for your complete setup.

---
#### File Structure Overview

- **`flake.nix`**  
  Defines how the system is composed (e.g., selecting your profile, GPU drivers, desktop environment, etc.).

- **`compose/`**  
  Contains universal settings that apply to every configuration.
  - **`home.nix`** — Universal home settings.
  - **`system.nix`** — Universal system settings.

- **`profile/option/`**  
  Contains machine-specific settings for various environments (e.g., WSL, virtual machines, Apple Silicon, standalone systems, servers, etc.).
  - **`home.nix`** — Profile-specific home settings.
  - **`system.nix`** — Profile-specific system settings.

- **`desktop/option/`**  
  Contains desktop-specific settings for any desktop environment (window managers or desktop environments).  
  _Optional Subdirectories (for further specialization):_
  - **`virtual-machine/`**  
    - **`home.nix`** — Desktop settings for virtual machine environments.
    - **`system.nix`** — Desktop settings for virtual machine environments.
  - **`server/`**  
    - **`home.nix`** — Desktop settings for server environments.
    - **`system.nix`** — Desktop settings for server environments.

- **`modules/`**  
  Provides extra features and module clusters (e.g., `modules/system/hardware.nix` for hardware-specific settings).

#### Building an ISO
- Define your Image-specific Profile within `flake.nix`.
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

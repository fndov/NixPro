### NixPro - 📸 Photograph
![2025-06-05_20-00-46](https://github.com/user-attachments/assets/c1fb13b9-9f2c-4bbb-881b-c7bb6175d8d6)
---
#### File structure & composition
```
┌─ kernel-patches/
├─ modules/
│  ├─ desktop/
│  ├─ apps/
│  ├─ commands/
│  └─ development/
├─ profile/
│  ├─ darwin/
│  ├─ image/
│  ├─ server/
│  ├─ virtual-machine/
│  ├─ windows-subsystem/
│  └─ workstation/
├─ flake.nix
└─ compose.nix
```
#### Profiles
NixPro employs a profile-driven architecture to support seamless adaptation across environments. The configuration dynamically adjusts settings and imports environment-specific modules based on the profile you specify in the build command.

| Profile             | Target Environment       | Hostname         | Use Case                                                                 |
|---------------------|--------------------------|------------------|-------------------------------------------------------------------------|
| `workstation`       | Bare-metal Installation  | NixPro           | Default setup for physical workstations/laptops                         |
| `darwin`            | ARM Apple Machines       | NixPro-ARM       | Apple Silicon optimizations (M1/M2 Macs)                                |
| `windows-subsystem` | WSL Environment          | NixPro-WSL       | Windows Subsystem for Linux integration                                 |
| `server`            | Headless Servers         | NixPro-Server    | Server-oriented configuration without GUI components                    |
| `virtual-machine`   | Virtualization Platforms | NixPro-VM        | Optimized for QEMU/VirtualBox/VMware workloads                          |
| `image`             | ISO Generation           | NixPro-Image     | Building live/installation media (see ISO building section below)       |
#### Building an ISO
![Screenshot 2025-02-19 at 12-39-48 Wed 11 36 AM](https://github.com/user-attachments/assets/8056f514-e651-4cf8-97f6-b439d39f0a01)
---
- Choose the profile you want to build an ISO for.
- Run `nix build .#nixosConfigurations.<profile-name>.config.system.build.isoImage` to build the ISO image.

| Version | Desktop  | Architecture  | Features                           |
| :------ | :------: | :-----------: | :---------------------------------: |
| 24.11   | hyprland | x86_64-linux  | GPU acceleration, tiling WM          |
| 22.05   | plasma   | x86_64-linux  | Full KDE desktop, productivity apps  |
| 23.11   | sway     | x86_64-linux  | Wayland compositor, minimal footprint|
#### Windows Subsystem for Linux
- Select the Microsoft-specific profile when building.
- This will automatically import the essential utilities for WSL.
---
This structure allows the system to be dynamically composed from universal, profile-specific, and desktop-specific modules, making it highly modular and easy to extend or maintain.

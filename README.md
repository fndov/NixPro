#### NixPro - 📸 Photograph
![20250226_16h44m39s_grim](https://github.com/user-attachments/assets/a1d1c2b7-b058-448f-968a-03687c2e5f14)
---
#### File structure & composition
```
┌─ flake.nix
├─ compose.nix
├─ desktop/option
├─ profile/option
│  ├─ default.nix
│  └─ hardware.nix
└─ modules
```
#### Profiles
NixPro employs a profile-driven architecture to support seamless adaptation across environments. The configuration dynamically adjusts settings and imports environment-specific modules based on your selected profile in `flake.nix`

| Profile             | Target Environment       | Hostname         | Use Case                                                                 |
|---------------------|--------------------------|------------------|-------------------------------------------------------------------------|
| `workstation`       | Bare-metal Installation  | NixPro           | Default setup for physical workstations/laptops                         |
| `darwin`            | ARM Apple Machines       | NixPro-ARM       | Apple Silicon optimizations (M1/M2 Macs)                                |
| `windows-subsystem` | WSL Environment          | NixPro-WSL       | Windows Subsystem for Linux integration                                 |
| `server`            | Headless Servers         | NixPro-Server    | Server-oriented configuration without GUI components                    |
| `virtual-machine`   | Virtualization Platforms | NixPro-VM        | Optimized for QEMU/VirtualBox/VMware workloads                          |
| `installation-media`| ISO Generation           | NixPro-Image     | Building live/installation media (see ISO building section below)       |
#### Building an ISO
![Screenshot 2025-02-19 at 12-39-48 Wed 11 36 AM](https://github.com/user-attachments/assets/8056f514-e651-4cf8-97f6-b439d39f0a01)
---
- Define your Image-specific Profile in `flake.nix`.
- Run `nix build .#nixosConfigurations.installation-media.config.system.build.isoImage --impure` to build the ISO image.
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

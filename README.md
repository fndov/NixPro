### NixPro - 📸 Photograph
![2025-06-05_20-00-46](https://github.com/user-attachments/assets/c1fb13b9-9f2c-4bbb-881b-c7bb6175d8d6)
---
#### File structure & composition
```
┌─ kernel-patches/       | Customizations.
├─ modules/              | Reuseable code.
│  ├─ apps/
│  ├─ commands/
│  ├─ desktop/
│  └─ development/
├─ profile/              | Each device that shares this flake.
│  ├─ image/
│  ├─ server/
│  ├─ virtual-machine/
│  ├─ windows-subsystem/
│  └─ workstation/
├─ flake.nix             | Start
└─ compose.nix           | Common code for all profiles.
```

| Profile             | Target Environment       | Hostname         | Use Case                                                                |
|---------------------|--------------------------|------------------|-------------------------------------------------------------------------|
| `image`             | ISO Generation           | NixPro-Image     | nixos-rebuild build-image (see 25.05 release notes)                     |
| `server`            | Headless Servers         | NixPro-Server    | Server-oriented or VPS configuration                                    |
| `virtual-machine`   | Virtualization Platforms | NixPro-VM        | Optimized for QEMU/containerized workloads                              |
| `windows-subsystem` | WSL Environment          | NixPro-WSL       | Windows Subsystem for Linux integration                                 |
| `workstation`       | Bare-metal Installation  | NixPro           | Default setup for physical workstations/laptops                         |

If more than one device uses the same profile, a copy can be created. Ex workstation-B. Instead of separating arbitrary device specific code out to another directory.

Another goal of this flake is to support multiple devices using the same profile without overlap or conflict, and to support multiple users both locally and online. However, whoever reads the README should know I haven't yet refactored the flake to avoid hard-coding my preferences, take the `apps.nix` file for example.

One of the many benefits of NixOS is the store architecture, you don't need to use exclusively stable or unstable channels, this flake mixes both.

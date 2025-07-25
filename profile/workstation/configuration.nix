{ pkgs, ... }: { imports = [
  ../../modules/apps/collection.nix
  ../../modules/apps/spotify.nix
  ../../modules/apps/steam.nix
  # ../../modules/apps/flatpak.nix
  # ../../modules/apps/virtualize.nix
  ../../modules/commands/base.nix
  ../../modules/commands/shell.nix
  ../../modules/commands/extra.nix
  ../../modules/commands/library.nix
  ../../modules/development/nix.nix
  ../../modules/development/rs.nix
  ];
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
  };
  boot.kernel.sysctl."vm.swappiness" = 1; # 60
  boot.kernel.sysctl."vm.dirty_background_ratio" = 5; # 10
  boot.kernel.sysctl."vm.dirty_ratio" = 10; # 20
  boot.kernel.sysctl."vm.vfs_cache_pressure" = 10; # 100
  boot.kernel.sysctl."vm.min_free_kbytes" = 1000; # 1000
  boot.kernel.sysctl."vm.compaction_proactiveness" = 100; # 20
  boot.kernel.sysctl."vm.page-cluster" = 3;
  boot.kernel.sysctl."vm.watermark_boost_factor" = 0;
  boot.kernel.sysctl."vm.watermark_scale_factor" = 125;
  boot.kernel.sysctl."vm.dirty_expire_centisecs" = 6000;
  boot.kernel.sysctl."vm.dirty_writeback_centisecs" = 1500;
  boot.kernelPackages = pkgs.linuxPackages_xanmod;
  boot.kernelPatches = [ ];
  boot.kernelParams = [
    "splash"
    "quiet"
    "rd.systemd.show_status=false"
    "udev.log_level=0"
    "rd.udev.log_level=0"
    "udev.log_priority=0"
    "fastboot"
    "mitigations=off"
    "noibrs"
    "noibpb"
    "nopti"
    "nospectre_v1"
    "nospectre_v2"
    "l1tf=off"
    "nospec_store_bypass_disable"
    "no_stf_barrier"
    "mds=off"
    "tsx=on"
    "tsx_async_abort=off"
    "nowatchdog"
    "panic=1"
    "boot.panic_on_fail"
    "transparent_hugepage=always"
    "init_on_alloc=0"
    "init_on_free=0"
    "idle=nomwait"
    "ascpi_osi=Linux"
    "preempt=full"
    "uinput"
  ];
  boot.blacklistedKernelModules = [
    "nouveau"   # Conflicts with Nvidia driver
    # Obscure network protocols.
    "af_802154" # IEEE 802.15.4
    "appletalk" # Appletalk
    "atm"       # ATM
    "ax25"      # Amatuer X.25
    "can"       # Controller Area Network
    "dccp"      # Datagram Congestion Control Protocol
    "decnet"    # DECnet
    "econet"    # Econet
    "ipx"       # Internetwork Packet Exchange
    "n-hdlc"    # High-level Data Link Control
    "netrom"    # NetRom
    "p8022"     # IEEE 802.3
    "p8023"     # Novell raw IEEE 802.3
    "psnap"     # SubnetworkAccess Protocol
    "rds"       # Reliable Datagram Sockets
    "rose"      # ROSE
    "sctp"      # Stream Control Transmission Protocol
    "tipc"      # Transparent Inter-Process Communication
    "x25"       # X.25
    # Old or rare or insufficiently audited filesystems.
    "adfs"     # Active Directory Federation Services
    "affs"     # Amiga Fast File System
    "befs"     # "Be File System"
    "bfs"      # BFS, used by SCO UnixWare OS for the /stand slice
    "cifs"     # Common Internet File System
    "cramfs"   # compressed ROM/RAM file system
    "efs"      # Extent File System
    "erofs"    # Enhanced Read-Only File System
    "exofs"    # EXtended Object File System
    "f2fs"     # Flash-Friendly File System
    "freevxfs" # Veritas filesystem driver
    "gfs2"     # Global File System 2
    "hfs"      # Hierarchical File System (Macintosh)
    "hfsplus"  # Same as above, but with extended attributes.
    "hpfs"     # High Performance File System (used by OS/2)
    "jffs2"    # Journalling Flash File System (v2)
    "jfs"      # Journaled File System - only useful for VMWare sessions
    "ksmbd"    # SMB3 Kernel Server
    "minix"    # minix fs - used by the minix OS
    "nfs"      # Network File System
    "nfsv3"    # Network File System (v3)
    "nfsv4"    # Network File System (v4)
    "nilfs2"   # New Implementation of a Log-structured File System
    "omfs"     # Optimized MPEG Filesystem
    "qnx4"     # Extent-based file system used by the QNX4 OS.
    "qnx6"     # Extent-based file system used by the QNX6 OS.
    "squashfs" # compressed read-only file system (used by live CDs)
    "sysv"     # implements all of Xenix FS, SystemV/386 FS and Coherent FS.
    "udf"      # https://docs.kernel.org/5.15/filesystems/udf.html
    "vivid"    # Virtual Video Test Driver (unnecessary)
    # Disable Thunderbolt and FireWire to prevent DMA attacks
    "firewire-core"
  ];
}

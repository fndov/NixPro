{ lib, pkgs, ... }:{
  imports = [ ];
  boot.kernelPackages = pkgs.linuxPackages_xanmod;
  boot.kernelParams = [
    "vga=0x317"
    "splash"
    "rd.systemd.show_status=false"
    "udev.log_level=0"
    "rd.udev.log_level=0"
    "udev.log_priority=0"
    "noibrs"
    "noibpb"
    "nopti"
    "l1tf=off"
    "nospec_store_bypass_disable"
    "no_stf_barrier"
    "mds=off"
    "tsx=on"
    "tsx_async_abort=off"
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
    "nouveau"
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
    "thunderbolt"
  ];
  systemd.services."serial-getty@ttyS0".enable = lib.mkDefault false;
  systemd.services."serial-getty@hvc0".enable = false;
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@".enable = false;
  systemd.enableEmergencyMode = false;
  boot.loader.grub.splashImage = null;
}

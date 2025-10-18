{ pkgs, ... }: { imports = [
  ../../modules/apps/collection.nix
  ../../modules/apps/spotify.nix
  ../../modules/apps/lutris.nix
  ../../modules/apps/steam.nix
  ../../modules/development/nix.nix
  ../../modules/commands/base.nix
  ../../modules/commands/shell.nix
  ../../modules/commands/library.nix
  ../../modules/commands/extra.nix
  ../../modules/development/cc.nix
  ../../modules/development/rs.nix
  ../../modules/development/py.nix
  ../../modules/development/nix.nix
  # ../../modules/apps/virtual-machine.nix
  # ../../modules/apps/flatpak.nix
  ];
  environment.memoryAllocator.provider = "libc";
  boot.kernelPackages = pkgs.linuxPackages_xanmod; /*
  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  services.scx.enable = true; */
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
  };
  boot.kernel.sysctl = {
    "vm.swappiness" = 1;
    "vm.dirty_background_ratio" = 5;
    "vm.dirty_ratio" = 10;
    "vm.vfs_cache_pressure" = 10;
    "vm.min_free_kbytes" = 1000;
    "vm.compaction_proactiveness" = 100;
    "vm.page-cluster" = 3;
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
    "vm.dirty_expire_centisecs" = 6000;
    "vm.dirty_writeback_centisecs" = 1500;

    "kernel.unprivileged_userns_clone" = 1;
    "net.core.default_qdisc" = "cake";
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.core.netdev_max_backlog" = 16384;
    "net.core.somaxconn" = 8192;
    "net.core.rmem_default" = 1048576;
    "net.core.rmem_max" = 16777216;
    "net.core.wmem_default" = 1048576;
    "net.core.wmem_max" = 16777216;
    "net.core.optmem_max" = 65536;
    "net.ipv4.tcp_rmem" = "4096 1048576 2097152";
    "net.ipv4.tcp_wmem" = "4096 65536 16777216";
    "net.ipv4.udp_rmem_min" = 8192;
    "net.ipv4.udp_wmem_min" = 8192;
    "net.ipv4.tcp_fastopen" = 3;
    "net.ipv4.tcp_max_syn_backlog" = 8192;
    "net.ipv4.tcp_max_tw_buckets" = 2000000;
    "net.ipv4.tcp_tw_reuse" = 1;
    "net.ipv4.tcp_fin_timeout" = 10;
    "net.ipv4.tcp_slow_start_after_idle" = 0;
    "net.ipv4.tcp_keepalive_time" = 60;
    "net.ipv4.tcp_keepalive_intvl" = 10;
    "net.ipv4.tcp_keepalive_probes" = 6;
    "net.ipv4.tcp_mtu_probing" = 1;
    "net.ipv4.tcp_sack" = 1;
    "net.ipv4.ip_local_port_range" = "30000 65535";
    "net.ipv4.tcp_syncookies" = 1;
    "net.ipv4.tcp_rfc1337" = 1;
    "net.ipv4.conf.default.rp_filter" = 1;
    "net.ipv4.conf.all.rp_filter" = 1;
    "net.ipv4.conf.default.log_martians" = 1;
    "net.ipv4.conf.all.log_martians" = 1;
    "net.ipv4.conf.all.accept_redirects" = 0;
    "net.ipv4.conf.default.accept_redirects" = 0;
    "net.ipv4.conf.all.secure_redirects" = 0;
    "net.ipv4.conf.default.secure_redirects" = 0;
    "net.ipv6.conf.all.accept_redirects" = 0;
    "net.ipv6.conf.default.accept_redirects" = 0;
    "net.ipv4.tcp_ecn" = 0;
    "fs.inotify.max_user_watches" = 524288;
  };
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

    # YOLO
    "rtsx_pci_sdmmc"
    "macvlan"
    "efi_pstore"
    "dmi_sysfs"
    "int3403_thermal"
    "int3400_thermal"
    "mac_hid"
    "i2c_hid_acpi"
    "hp_accel"
    "processor_thermal_device_pci_legacy"
    "i2c_i801"
    "battery"
    "tpm_tis"
    "mei_pxp"
    "hp_wmi"
    "wmi_bmof"
    "rapl"
    "intel_cstate"
    "intel_uncore"
    "tpm_crb"
    "hid_multitouch"
    "crc32_pclmul"
    "polyval_clmulni"
    "ghash_clmulni_intel"
    "mei_hdcp"
    "ee1004"
    "intel_wmi_thunderbolt"
    "intel_rapl_msr"
    "vhost_net"
    "snd_seq_dummy"
    "nvidia_uvm"
    "snd_sof_pci_intel_skl"
    "iwlmvm"
    "snd_soc_avs"
    "iTCO_wdt"
    "r8169"
    "intel_tcc_cooling"
    "x86_pkg_temp_thermal"
    "intel_powerclamp"
    "coretemp"
    "ac"
    "mousedev"
    "btusb"
    "tiny_power_button"
  ];
}

{ pkgs, ... }: { imports = [
  ../../modules/apps/collection.nix
  ../../modules/apps/spotify.nix
  ../../modules/apps/flatpak.nix
  ../../modules/apps/steam.nix
  ../../modules/apps/heroic.nix
  ../../modules/commands/base.nix
  ../../modules/commands/shell.nix
  ../../modules/commands/library.nix
  ../../modules/commands/extra.nix
  ../../modules/development/nix.nix
  ../../modules/development/cc.nix
  ../../modules/development/rs.nix
  ../../modules/development/py.nix
  ../../modules/development/nix.nix
  ];
  boot.kernelPackages = pkgs.linuxPackages_xanmod;
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
  ];
}

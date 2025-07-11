{inputs, ...}: let
  fs = import ../../../modules/filesystems;
  lvm = fs.type "lvm" {};
  disk = fs.disk {name = diskPath;};

  diskPath = "/dev/by-id/nvme-...";
  espSize = "512M";
  swapSize = "32G";
  rootSize = "30G";
  storeSize = "50G";
  btrfsSize = "100G";
  logSize = "1G";
  hybernation = false;
in {
  imports = [
    inputs.disko.nixosModules.disko
  ];
  disko.devices.disk = {
    NVME = disk.gpt {
      partitions = {
        ESP = fs.esp {size = espSize;};
        LVM = lvm.partition;
      };
    };
  };
  disko.devices.nodev = fs.tmpfs {
    size = rootSize;
    mountpoint = "/";
  };
  disko.devices.lvm_vg = lvm.group {
    partitions = {
      SWAP = fs.swap {
        size = swapSize;
        hybernation = hybernation;
      };
      STORE = fs.f2fs {
        size = storeSize;
        mountpoint = "/nix";
      };
      LOG = fs.f2fs {
        size = logSize;
        mountpoint = "/var/log";
      };
      BTRFS = fs.btrfs.partition {
        size = btrfsSize;
        subvolumes = {
          "@home" = {mountpoint = "/home";};
          "@persist" = {mountpoint = "/persist";};
        };
      };
    };
  };
}

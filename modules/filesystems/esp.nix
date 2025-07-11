{size}: {
  type = "EF00";
  size = size;
  content = {
    type = "filesystem";
    format = "vfat";
    mountpoint = "/boot";
    mountOptions = [
      "defaults"
      "umask=0077" # No access for group or others.
    ];
  };
}

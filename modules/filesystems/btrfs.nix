{
  partition = {
    size,
    subvolumes,
  }: {
    size = size;
    content.type = "btrfs";
    content.extraArgs = ["-f"];
    content.subvolumes = subvolumes;
  };
  subvolume = {
    mountpoint,
    mountOptions ? [
      "compress=zstd"
      "noatime"
      "nodiratime"
      "discard"
    ],
  }: {
    inherit mountOptions mountpoint;
  };
}

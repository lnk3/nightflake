{
  mountpoint,
  size,
}: {
  ${toString mountpoint} = {
    fsType = "tmpfs";
    mountpoint = mountpoint;
    mountOptions = [
      "defaults"
      "mode=755"
      "size=${size}"
    ];
  };
}

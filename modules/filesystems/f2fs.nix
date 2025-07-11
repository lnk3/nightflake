{
  size,
  mountpoint,
}: {
  size = size;
  content.type = "filesystem";
  content.format = "f2fs";
  content.mountpoint = mountpoint;
  content.extraArgs = [
    "-i" # Enable extended node bitmap allow more space for inodes https://lore.kernel.org/all/CAF_dkJB%3d2PAqes+41xAi74Z3X0dSjQzCd9eMwDjpKmLD9PBq6A
    "-l STORE" # Specify volume label
    "-O"
    "extra_attr,inode_checksum,sb_checksum,compression"
  ];
  # Recommendations for flash: https://wiki.archlinux.org/title/F2FS#Recommended_mount_options
  content.mountOptions = [
    "compress_algorithm=zstd:6," # tells F2FS to use zstd for compression at level 6, which should give pretty good compression ratio.
    # "compress_chksum," # tells the filesystem to verify compressed blocks with a checksum (to avoid corruption)
    "atgc,gc_merge," # Enable better garbage collector, and enable some foreground garbage collections to be asynchronous.
    "lazytime" # Do not synchronously update access or modification times. Improves IO performance and flash durability.
    # "nodiscard" # Disable continuos discard, which is when trimming happens each time files are deleted
  ];
}

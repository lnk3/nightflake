{
  type = name: import ./${name}.nix;

  btrfs = import ./btrfs.nix;
  disk = import ./disk.nix;
  esp = import ./esp.nix;
  f2fs = import ./f2fs.nix;
  lvm = import ./lvm.nix;
  swap = import ./swap.nix;
  tmpfs = import ./tmpfs.nix;
}

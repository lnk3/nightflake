{name ? "GROUP"}: {
  inherit name;
  partition = {
    content.type = "lvm_pv";
    content.vg = name;
  };
  group = {partitions}: {
    ${toString name} = {
      type = "lvm_vg";
      lvs = partitions;
    };
  };
}

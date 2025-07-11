{name}: {
  gpt = {partitions}: {
    device = name;
    type = "disk";
    content.type = "gpt";
    content.partitions = partitions;
  };
}

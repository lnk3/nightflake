{
  size,
  hybernation,
}: {
  size = size;
  content.type = "swap";
  content.discardPolicy = "pages";
  content.resumeDevice = hybernation;
}

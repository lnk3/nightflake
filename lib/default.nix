{
  lib ? (builtins.getFlake (toString ../.)).inputs.nixpkgs.lib,
  inputs ? (builtins.getFlake (toString ../.)).inputs,
  outputs ? (builtins.getFlake (toString ../.)).outputs,
  stateVersion ? "25.05",
  ...
}: {
  outputs = import ./outputs.nix {inherit inputs outputs stateVersion;};
}

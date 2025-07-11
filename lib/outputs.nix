{
  inputs ? (builtins.getFlake (toString ./.)).inputs,
  outputs ? (builtins.getFlake (toString ./.)).outputs,
  stateVersion ? "25.05",
  ...
}: {
  mkHome = {
    hostname,
    username ? "user",
    desktop ? null,
    platform ? "x86_64-linux",
  }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${platform};
      extraSpecialArgs = {
        inherit
          inputs
          outputs
          stateVersion
          hostname
          username
          desktop
          platform
          ;
      };
      modules = [../home-manager];
    };

  mkNixos = {
    extraSpecialArgs ? {},
    device ? "",
    configuration,
    hostname,
    username ? "user",
    desktop ? null,
    platform ? "x86_64-linux",
    iso ? false,
  }:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs =
        {
          inherit
            inputs
            outputs
            stateVersion
            hostname
            username
            desktop
            platform
            ;
        }
        // extraSpecialArgs;
      modules =
        [
          ../configurations/${configuration}
        ]
        ++ inputs.nixpkgs.lib.optionals (!iso) [
          ../devices/${device}
        ];
    };
}

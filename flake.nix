{
  description = ''

     _  _ _      _   _    __ _      _
    | \| (_)__ _| |_| |_ / _| |__ _| |_____
    | .` | / _` | ' \  _|  _| / _` | / / -_)
    |_|\_|_\__, |_||_\__|_| |_\__,_|_\_\___|
           |___/

    This flake never steals food, never shows itself, and never misses.
  '';

  outputs = inputs @ {self, ...}: let
    inherit (self) outputs;
    inherit (inputs) nixpkgs;

    lib = nixpkgs.lib.extend (
      lib: prev:
        import ./lib {inherit inputs outputs lib;} // prev
    );
  in {
    inherit lib;
    nixosConfigurations = {
      "cloudjumper" = lib.outputs.mkNixos {
        device = "tower";
        configuration = "beefy";
        hostname = "tower";
        username = "user";
      };
    };
  };

  # Use the following to list inputs of a flake, this is needed to list possible `follows`
  # parallel --ctag "nix flake metadata {} 2>/dev/null | sed -nEe '/Inputs/,$ p' | sed 's/:.*//'" ::: FLAKE_REFERENCES

  # parallel "nix flake metadata {} 2>/dev/null | sed -n '/Inputs/,$ p' | sed 's/:.*//' | sed 's/└.* follows.*//' | sed 's/[├│─└]//g' | sed 's/ follows.*//' | sed -E 's/^\s+//' | tail +2" ::: "" github:kamadorueda/alejandra | sort | uniq --repeated
  inputs = {
    nixpkgs.follows = "unstable";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    stable.url = "github:nixos/nixpkgs/nixos-24.05";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };
}

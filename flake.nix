{
  description = "Convert cabal files to json";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = {
    nixpkgs,
    self,
  } @ inp: let
    l = nixpkgs.lib // builtins;
    supportedSystems = ["x86_64-linux"];

    forAllSystems = f: l.genAttrs supportedSystems
      (system: f system nixpkgs.legacyPackages.${system});

  in {
    devShell = forAllSystems (system: pkgs: pkgs.mkShell {
      buildInputs = with pkgs; [
        stack
        ghcid
      ];
    });
  };
}

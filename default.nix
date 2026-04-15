let
  sources = builtins.mapAttrs (_: outPath: { inherit outPath; }) (import ./lon);
  with-inputs = import sources.with-inputs.outPath sources (import ./inputs.nix);

  outputs =
    inputs:
    (inputs.nixpkgs.lib.evalModules {
      specialArgs = { inherit inputs; self = inputs.self; };
      modules = [ (inputs.import-tree ./modules) ];
    }).config;
in
  with-inputs outputs
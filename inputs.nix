{
  flake-utils.lib.eachDefaultSystem = fn:
    builtins.mapAttrs (_: v: { x86_64-linux = v; }) (fn "x86_64-linux");
}
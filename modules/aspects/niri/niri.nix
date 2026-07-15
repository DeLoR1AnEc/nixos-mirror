{ __findFile, ... }:
{
  den.aspects.niri = {
    includes = [
      <wayland>
      <quickshell>
    ];

    nixos =
      { config, lib, pkgs, ... }:
      let
        cfg = config.outputs;

        outputToKdl = name: body: ''
          output "${name}" {
            ${body}
          }
        '';

        outputsKdl = lib.concatStringsSep "\n" (lib.mapAttrsToList outputToKdl cfg);

        fullConfig = ''
          ${builtins.readFile ./config.kdl}
          ${outputsKdl}
        '';
      in
      {
        options.outputs = lib.mkOption {
          type = lib.types.attrsOf lib.types.lines;
          default = { };
          description = "Per-host niri output blocks, keyed by connector name. Value is the raw KDL body placed inside output \"name\" { ... }.";
        };

        config = {
          environment.systemPackages = [ pkgs.xwayland-satellite ];
          programs.niri.enable = true;
          environment.etc."niri-generated-config.kdl".source = pkgs.writeText "niri-config.kdl" fullConfig;
        };
      };

    maid =
      { pkgs, ... }:
      {
        file.xdg_config."niri/config.kdl".source = "/etc/niri-generated-config.kdl";
      };
  };
}

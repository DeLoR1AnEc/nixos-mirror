{ inputs, ... }:
{
  den.aspects.noctalia = {
    nixos.imports = [ inputs.noctalia-shell.nixosModules.default ];

    maid =
      { pkgs, ... }:
      {
        packages = [ pkgs.noctalia-shell ];

        file.xdg_config."noctalia/settings.json".source = ./settings.json;
        systemd.services.noctalia-shell = {
          script = ''exec noctalia-shell'';
          wantedBy = [ "graphical-session.target" ];
        };
      };
  };
}
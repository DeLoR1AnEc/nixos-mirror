{
  den.aspects.noctalia.maid =
    { pkgs, ... }:
    {
      packages = [ pkgs.noctalia-shell ];

      file.xdg_config."noctalia/settings.json".source = ./settings.json;
    };
}
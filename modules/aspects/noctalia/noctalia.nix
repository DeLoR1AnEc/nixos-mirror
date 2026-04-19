{
  den.aspects.noctalia.maid =
    { pkgs, ... }:
    {
      packages = with pkgs; [
        noctalia-shell
        noctalia-qs
      ];

      file.xdg_config."noctalia/settings.json".source = ./settings.json;
    };
}
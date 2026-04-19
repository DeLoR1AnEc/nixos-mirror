{
  den.aspects.noctalia = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          noctalia-shell
          noctalia-qs
        ];
      };

    maid.file.xdg_config."noctalia/settings.json".source = toString ./settings.json;
  };
}
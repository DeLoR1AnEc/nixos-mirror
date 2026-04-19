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

    maid.file.xdg_config."settings.json".source = toString ./settings.json;
  };
}
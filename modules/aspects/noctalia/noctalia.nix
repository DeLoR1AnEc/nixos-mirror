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

    maid.file.xdg_config_home."noctalia/settings.json".source = ./settings.json;
    maid.file.xdg_config_home."test".text = ''
      test
    '';
  };
}
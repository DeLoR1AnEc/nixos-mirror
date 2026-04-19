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

    nix-maid.file.xdg_config."noctalia/settings.json".source = ./settings.json;
  };
}
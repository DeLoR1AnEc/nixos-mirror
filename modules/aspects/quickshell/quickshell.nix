{
  den.aspects.quickshell = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [ pkgs.quickshell ];
      };

    maid = {
      file.xdg_config."quickshell/minimalist".source = ./config;
    };
  };
}

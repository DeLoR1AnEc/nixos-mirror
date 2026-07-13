{ __findFile, ... }:
{
  den.aspects.niri = {
    includes = [
      <wayland>
      <noctalia>
    ];

    nixos =
      { config, lib, pkgs, ... }:
      {
        environment.systemPackages = [ pkgs.xwayland-satellite ];
        programs.niri.enable = true;
      };

    maid =
      { pkgs, ... }:
      {
        file.xdg_config."niri/config.kdl".source = ./config.kdl;
      };
  };
}

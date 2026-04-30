{ __findFile, ...}:
{
  den.aspects.niri = {
    includes = [
      <wayland>
      <noctalia>
    ];

    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [ pkgs.xwayland-satellite ];
        programs.niri.enable = true;
      };

    maid =
      { pkgs, ... }:
      {
        file.xdg_config."niri/config.kdl".source = pkgs.substituteAll {
          src = ./config.kdl;
        };
      };
  };
}
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

    file.xdg_config."niri/config.kdl".source = ./config.kdl;
  };
}
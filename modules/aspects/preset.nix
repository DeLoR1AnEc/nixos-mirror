{ den, __findFile, ... }:
{
  den.aspects.preset._ = {
    base = den.lib.parametric.atLeast {
      includes = [
        <boot>

        <networking>
        <locales>
        <secrets>
        <xdg>

        <apps>
        <shell>
      ];
    };

    desktop = den.lib.parametric.atLeast {
      includes = [
        <preset/base>

        <boot/greeter>
        <preservation>
        <zram>

        <niri>
      ];
    };
  };
}
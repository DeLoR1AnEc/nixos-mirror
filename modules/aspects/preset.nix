{ den, __findFile, ... }:
{
  den.default.includes = [
    <boot>

    <networking>
    <locales>
    <secrets>
    <xdg>

    <apps>
    <shell>
  ];

  den.aspects.preset._ = {
    desktop = den.lib.parametric.atLeast {
      includes = [
        <boot/greeter>
        <preservation>
        <zram>

        <niri>
        <terminal>
      ];
    };
  };
}
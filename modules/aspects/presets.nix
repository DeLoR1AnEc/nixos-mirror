{ den, __findFile, ... }:
{
  den.default.includes = [
    <boot>

    <networking>
    <locales>
    <secrets>
    <xdg>

    <git>
    <apps>
    <shell>

    # <boot/secure>
    # <boot/greeter>
    # <preservation>
    # <zram>

    # <terminal>
    # <browser>
    # <niri>
  ];

  den.aspects.presets._ = {
    desktop = den.lib.parametric {
      includes = [
        <boot/secure>
        <boot/greeter>
        <preservation>
        <zram>

        <terminal>
        <browser>
        <niri>
      ];
    };
  };
}
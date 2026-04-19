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

    # desktop
    # <boot/secure>
    # <boot/greeter>
    # <preservation>
    # <zram>

    # <terminal>
    # <niri>
  ];

  den.aspects.preset._ = {
    desktop = {
      includes = [
        <boot/secure>
        <boot/greeter>
        <preservation>
        <zram>

        <terminal>
        <niri>
      ];
    };
  };
}
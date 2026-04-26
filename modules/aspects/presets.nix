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
  ];

  den.aspects.presets._ = {
    desktop = den.lib.perUser {
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
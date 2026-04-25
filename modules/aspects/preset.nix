{ __findFile, ... }:
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

  den.aspects.preset._ = {
    desktop = {
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
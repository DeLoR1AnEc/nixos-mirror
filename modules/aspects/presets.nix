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

  den.aspects.desktop = {
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
}
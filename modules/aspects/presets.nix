{ __findFile, ... }:
{
  den.default.includes = [
    <boot>

    <networking>
    <networking/ssh>
    <locales>
    <secrets>
    <xdg>

    <git>
    <apps>
    <shell>
  ];

  den.aspects.presets._ = {
    desktop.includes = [
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
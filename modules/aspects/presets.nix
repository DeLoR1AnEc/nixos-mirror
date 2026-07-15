{ den, __findFile, ... }:
{
  den.default.includes = [
    den.batteries.hostname

    <boot>

    <networking>
    <networking/ssh>
    <locales>
    <secrets>
    <xdg>

    <git>
    <apps>
    <shell>
    <neovim>
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

      <bluetooth>
      <sync>
    ];
  };
}

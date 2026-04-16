{ inputs, den, ... }:
{
  _module.args.__findFile = den.lib.__findFile;
  imports = [
    inputs.den.flakeModule
  ];

  den.schema.user.classes = [ "maid" ];
}
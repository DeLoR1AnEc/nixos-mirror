{ inputs, den, __findFile, ... }:
let
  name = "electron";
in
{
  den.hosts.x86_64-linux.${name}.users.delorianec = {};
  den.aspects.${name} = {
    includes = [ (den.lib.perUser <presets/desktop>) ];

    nixos = {
      imports = [
        inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480

        inputs.disko.nixosModules.default
        ./_disko.nix
      ];

      hardware.facter.reportPath = ./facter.json;
      fileSystems."/log".neededForBoot = true;
    };
  };
}
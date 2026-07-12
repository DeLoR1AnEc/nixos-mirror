{ inputs, dlib, __findFile, ... }:
let
  name = "tau";
in
{
  den.hosts.x86_64-linux.${name}.users.delorianec = {};
  den.aspects.${name} = {
    nixos = {
      imports = [
        inputs.disko.nixosModules.default
        ./_disko.nix
      ];

      hardware.facter.reportPath = ./facter.json;
      fileSystems."/log".neededForBoot = true;
    };
  } // dlib.withUsers [ <presets/desktop> ];
}
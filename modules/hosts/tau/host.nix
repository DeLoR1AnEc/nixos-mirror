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

      outputs."HDMI-A-2" = ''
        mode "1920x1080@60"
	position x=1920 y=0
	scale 1.0
      '';

      outputs."DP-2" = ''
      	mode "3840x2160@160"
	position x=0 y=0
	scale 2.0
      '';
    };
  } // dlib.withUsers [ 
      <presets/desktop>
      <gaming>
    ];
}

{ inputs, lib, ... }:
{
  den.aspects.boot = {
    nixos = {
      boot.loader.systemd-boot = {
        enable = true;
        configurationLimit = 5;
        consoleMode = "max";
      };

      boot.loader.timeout = lib.mkDefault 8;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.supportedFilesystems = [ "ntfs" ];
    };

    _ = {
      secure.nixos = {
        imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

        boot = {
          loader.systemd-boot.enable = lib.mkForce false;

          lanzaboote.enable = true;
          lanzaboote.pkiBundle = "/etc/secureboot";
        };
      };

      greeter.nixos = {
        imports = [ inputs.sysc-greet.nixosModules.default ];

        services.sysc-greet.enable = true;
        services.sysc-greet.compositor = "niri";
      };
    };
  };
}
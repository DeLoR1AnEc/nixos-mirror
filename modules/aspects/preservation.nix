{ inputs, ... }:
{
  den.aspects.preservation.nixos = {
    imports = [ inputs.preservation.nixosModules.default ];

    preservation.enable = true;
    boot.initrd.systemd.enable = true;

    systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];

    fileSystems."/persistent".neededForBoot = true;
    preservation.preserveAt."/persistent" = {
      directories = [
        "/config"

        "/etc/ssh"
        "/etc/secureboot"
        "/etc/NetworkManager/system-connections"
        "/etc/nix/inputs"

        "/var/log"
        "/var/lib/nixos"
        "/var/lib/systemd"
        { directory = "/var/lib/private"; mode = "0700"; }
        "/var/lib/bluetooth"
        "/var/NetworkManager"
        "/var/tailscale"
        "/var/db/sudo/lectured"
      ];
      files = [
        { file = "/etc/machine-id"; inInitrd = true; }
        "/var/lib/sops-age-keys"
      ];
    };
  };
}
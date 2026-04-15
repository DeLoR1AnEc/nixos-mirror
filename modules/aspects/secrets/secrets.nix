{ inputs, ... }:
let
  sopsConfig = {
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/var/lib/sops-age-key";
  };
in
{
  den.aspects.secrets = {
    nixos =
      {
        imports = [ inputs.sops-nix.nixosModules.default ];
        sops = sopsConfig;
      };

    maid =
      { pkgs, ... }:
      {
        packages = [ pkgs.sops ];

        file.home.".bash_profile".text = ''
          export SOPS_AGE_KEY_FILE="${sopsConfig.age.keyFile}"
        '';
      };
  };
}
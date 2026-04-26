{ inputs, ... }:
let
  sopsConfig = {
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
    age = {
      keyFile = "/var/lib/sops-age-keys";
      generateKey = true;
    };
  };
in
{
  den.aspects.secrets = {
    nixos =
      { pkgs, ... }:
      {
        imports = [ inputs.sops-nix.nixosModules.default ];
        environment.systemPackages = with pkgs; [
          age sops
        ];
        sops = sopsConfig;
      };

    maid = {
      file.home.".bash_profile".text = ''
        export SOPS_AGE_KEY_FILE="${sopsConfig.age.keyFile}"
      '';
    };
  };
}
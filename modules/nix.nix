{ inputs, ... }:
{
  den.default.nixos =
    { pkgs, ... }:
    {
      imports = [ inputs.nix-index-database.nixosModules.default ];

      nixpkgs.config.allowUnfree = true;
      programs.nix-index-database.comma.enable = true;
      programs.nix-ld.enable = true;
      programs.nh = {
        enable = true;

        clean.enable = true;
        clean.dates = "weekly";
        clean.extraArgs = "--delete-older-than 7d";
      };

      nix = {
        package = pkgs.lixPackageSets.latest.lix;

        optimise.automatic = true;
        optimise.dates = "weekly";

        settings = {
          keep-outputs = true;
          keep-derivations = true;
          use-xdg-base-directories = true;
          auto-optimise-store = true;
          trusted-users = [ "@wheel" ];

          experimental-features = [ "nix-command" "flakes" ];

          trusted-substituters = [
            "https://nix-community.cachix.org"
          ];
          trusted-public-keys = [
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          ];

        };
      };

      nixpkgs.overlays = [
        (final: prev:
          let
            oldPkgs = import inputs.nixpkgs-old { inherit (prev) system; };
          in {
            substitute = oldPkgs.substitute;
            substituteAll = oldPkgs.substituteAll;
          })
      ];

      system.stateVersion = "25.11";
    };
}
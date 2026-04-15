{ inputs, ... }:
{
  den.default.nixos =
    { pkgs, ... }:
    {
      imports = [ inputs.nix-index-database.nixosModules.default ];

      environment.systemPackages = [ inputs.nie.packages.${pkgs.system}.default ];

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
        optimise.automatic = true;
        optimise.dates = "weekly";

        settings = {
          keep-outputs = true;
          keep-derivations = true;
          use-xdg-base-directories = true;
          auto-optimise-store = true;

          experimental-features = [ "nix-command" ];
        };
      };

      system.stateVersion = "25.11";
    };
}
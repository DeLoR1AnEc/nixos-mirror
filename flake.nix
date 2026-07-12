{
  outputs =
    inputs:
    (inputs.nixpkgs.lib.evalModules {
      specialArgs.inputs = inputs;
      modules = [ (inputs.import-tree ./modules )];
    }).config.flake;

  inputs = {
    # Packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-old.url = "github:nixos/nixpkgs/nixos-25.05";
    nur.url = "github:nix-community/NUR";

    # Maid
    nix-maid.url = "github:viperML/nix-maid";

    # Dendritic
    den.url = "github:vic/den";
    import-tree.url = "github:vic/import-tree";

    # Hardware
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nixos-facter.url = "github:nix-community/nixos-facter";
    disko.url = "github:nix-community/disko";

    # Programms
    sops-nix.url = "github:Mic92/sops-nix";
    sysc-greet.url = "github:Nomadcxx/sysc-greet";
    lanzaboote.url = "github:nix-community/lanzaboote";
    preservation.url = "github:nix-community/preservation";
    nix-index-database.url = "github:nix-community/nix-index-database";
  };
}
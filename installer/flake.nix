{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  outputs =
    { nixpkgs, ... }:
    let
      installer = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
          ({ pkgs, ... }: {
            environment.systemPackages = with pkgs; [
              git
              gum
              sbctl
              disko
              neovim
              nushell
              e2fsprogs
            ];

            services.openssh.enable = true;
            programs.ssh.startAgent = true;

            nix.settings.experimental-features = [ "nix-command" "flakes" ];

            services.getty.autologinUser = nixpkgs.lib.mkForce "root";
            environment.loginShellInit = ''
              if [ "$(tty)" = "/dev/tty1" ]; then
              echo ""
              echo " ______________________      "
              echo "< Run: nu /etc/install >     "
              echo " ----------------------      "
              echo "        \   ^__^             "
              echo "         \  (oo)\_______     "
              echo "            (__)\       )\/\ "
              echo "                ||----w |    "
              echo "                ||     ||    "
              echo ""
              fi
            '';

            environment.etc."install".source = ./install.nu;
            image.baseName = nixpkgs.lib.mkForce "installer";
          })
        ];
      };
    in
    {
      nixosConfigurations = { inherit installer; };
      packages.x86_64-linux.default =
        installer.config.system.build.image;
    };
}
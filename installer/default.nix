let
  sources = builtins.mapAttrs (_: outPath: { inherit outPath; }) (import ./lon);
  nixpkgs = sources.nixpkgs;
  pkgs = import (sources.nixpkgs) { };

  installer = pkgs.nixos [
    "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
    ({ pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        git
        gum
        sbctl
        disko
        neovim
        nushell
      ];

      services.openssh.enable = true;
      programs.ssh.startAgent = true;

      nix.settings.experimental-features = [ "nix-command" ];
      nix.nixPath = [ "nixpkgs=${nixpkgs}" ];

      services.getty.autologinUser = pkgs.lib.mkForce "root";
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
      image.baseName = pkgs.lib.mkForce "install";
    })
  ];
in
  installer.config.system.build.image
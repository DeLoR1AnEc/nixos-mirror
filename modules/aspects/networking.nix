{
  den.aspects.networking = {
    nixos.networking = {
      networkmanager.enable = true;
      nftables.enable = true;
      wireguard.enable = true;
    };

    _.ssh.nixos = {
      environment.enableAllTerminfo = true;
      programs.ssh.extraConfig = ''
        Host *
          IdentityFile /etc/ssh/host
      '';
      services.openssh = {
        enable = true;
        settings = {
          X11Forwarding = true;
          PermitRootLogin = "prohibit-password";
          PasswordAuthentication = false;
        };
        openFirewall = true;
      };
    };
  };
}
{
  den.aspects.sync.nixos = {
    services.syncthing = {
      enable = true;
      group = "user";
      user = "delorianec";
      dataDir = "/home/delorianec/sync";
      configDir = "/home/delorianec/.config/syncthing";
    };
  };
}

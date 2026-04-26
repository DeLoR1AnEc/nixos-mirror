{
  den.aspects.git.nixos.programs.git = {
    enable = true;
    config = {
      safe.directory = "/config";
      user.email = "delorianec@proton.me";
      user.name = "DeLoRiAnEc";
    };
  };
}
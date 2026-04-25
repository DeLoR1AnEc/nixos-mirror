{
  den.aspects.git.nixos.programs.git = {
    enable = true;
    config = {
      safe.directory = "/config";
    };
  };
}
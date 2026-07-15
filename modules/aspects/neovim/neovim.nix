{
  den.aspects.neovim = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          neovim
          git
          ripgrep
          fd
          gcc
          unzip
          nil
        ];

        environment.sessionVariables.EDITOR = "nvim";
      };

    maid.file.xdg_config."nvim".source = ./config;
  };
}

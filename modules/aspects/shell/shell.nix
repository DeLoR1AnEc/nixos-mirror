{
  den.aspects.shell = {
    nixos =
      { pkgs, ... }:
      {
        programs.bash.enable = true;
        programs.bash.completion.enable = true;

        users.defaultUserShell = pkgs.bashInteractive;
      };

    # maid =
    #   {
    #     file.home.".bash_profile".text = ''
    #       # Programming Languages
    #       export CARGO_HOME="{{xdg_data_home}}/cargo"
    #       export GOPATH="{{xdg_data_home}}/go"
    #       export GRADLE_USER_HOME="{{xdg_data_home}}/gradle"
    #       export NPM_CONFIG_CACHE="{{xdg_config_home}}/npm"
    #       export NPM_CONFIG_PREFIX="{{xdg_data_home}}/npm"
    #       export PYTHON_HISTORY="{{xdg_config_home}}/python/history"
    #       export _JAVA_OPTIONS="-Djava.util.prefs.userRoot={{xdg_config_home}}/java"

    #       # Misc
    #       export WINEPREFIX="{{xdg_data_home}}/wine"
    #       export XCOMPOSECACHE="{{xdg_cache_home}}/X11/xcompose"

    #       # Path
    #       export PATH="{{home}/.local/bin:$GOPATH:$CARGO_HOME:$NPM_CONFIG_PREFIX:$PATH"
    #     '';

    #     file.xdg_config."nushell/config.nu".source = ./config.nu;
    #   };
  };
}
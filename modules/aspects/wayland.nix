{
  den.aspects.wayland = {
    nixos =
      { pkgs, ... }:
      {
        programs.dconf.enable = true;
        environment = {
          systemPackages = [ pkgs.wl-clipboard ];
          sessionVariables.NIXOS_OZONE_WL = "1";
        };
      };

    maid =
      {
        files.".config/gtk-3.0/bookmarks".text = ''
          "file:///{{home}}/Downloads Downloads"
          "file:///{{home}}/Documents Documents"
          "file:///{{home}}/Coding Coding"
          "file:///{{home}}/Art Art"
        '';

        files.".config/gtk-3.0/settings.ini".text = ''
          [Settings]
          gtk-decoration-layout=appmenu:none
        '';
      };
  };
}
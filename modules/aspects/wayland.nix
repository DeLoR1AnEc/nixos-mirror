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
        file.".config/gtk-3.0/bookmarks".text = ''
          "file:///{{home}}/downloads Downloads"
          "file:///{{home}}/documents Documents"
          "file:///{{home}}/coding Coding"
          "file:///{{home}}/pictures Pictures"
        '';

        file.".config/gtk-3.0/settings.ini".text = ''
          [Settings]
          gtk-decoration-layout=appmenu:none
        '';
      };
  };
}
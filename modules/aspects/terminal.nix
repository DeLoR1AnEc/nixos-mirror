{
  den.aspects.terminal = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [ pkgs.foot ];
      };

    # maid =
    #   { pkgs, ... }:
    #   {
    #     file.xdg_config."foot/foot.ini".text = ''
    #       [main]
    #       term=foot
    #       font=Maple Mono NF:size=13
    #       dpi-aware=no
    #       resize-keep-grid=no
    #       shell=${pkgs.bash}/bin/bash --login -c 'nu --login --interactive'

    #       [mouse]
    #       hide-when-typing=yes
    #     '';
    #   };
  };
}
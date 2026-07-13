{
  den.aspects.apps.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        # Core
        just
        neovim
        gnumake
        nushell
        python3
        gum

        # System Monitoring
        fastfetch
        procs
        btop
        lurk

        # Archives
        zip
        xz
        zstd
        unzipNLS
        p7zip
        ouch

        # Text
        gnugrep
        gawk
        gnutar
        gnused
        sad
        choose

        jq
        yq
        jc

        # Files
        fzf
        fd
        findup
        (ripgrep.override { withPCRE2 = true; })

        edir

        # Disk
        duf
        dust
        gdu
        ncdu

        # Networking
        gping
        doggo
        wget
        curl
        curlie
        httpie
        aria2
        nmap
        ipcalc
        tcpdump
        whois
        traceroute

        # Misc
        file
        which
        tree
        tealdeer
        eva
        glow
        hexyl
        imagemagick
        progress
        try
        psutils
        psmisc
        pciutils

	# Temp
	fuzzel
      ];
    };
}

{
  den.aspects.xdg = {
    nixos.xdg.terminal-exec.enable = true;
    maid.file.xdg_config."user-dirs.dirs".text = ''
      XDG_DESKTOP_DIR=""
      XDG_TEMPLATES_DIR=""
      XDG_MUSIC_DIR=""
      XDG_PUBLICSHARE_DIR=""
      XDG_DOCUMENTS_DIR="{{home}}/documents"
      XDG_DOWNLOAD_DIR="{{home}}/downloads"
      XDG_PICTURES_DIR="{{home}}/pictures"
      XDG_VIDEOS_DIR="{{home}}/videos"
      XDG_CODING_DIR="{{home}}/coding"
    '';
  };
}
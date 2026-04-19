{
  den.aspects.xdg = {
    nixos.xdg.terminal-exec.enable = true;
    maid.file.xdg_config."user-dirs.dirs".text = ''
      XDG_DESKTOP_DIR=""
      XDG_TEMPLATES_DIR=""
      XDG_MUSIC_DIR=""
      XDG_PUBLICSHARE_DIR=""
      XDG_DOCUMENTS_DIR="$HOME/documents"
      XDG_DOWNLOAD_DIR="$HOME/downloads"
      XDG_PICTURES_DIR="$HOME/pictures"
      XDG_VIDEOS_DIR="$HOME/videos"
      XDG_CODING_DIR="$HOME/coding"
    '';
  };
}
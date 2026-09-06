{ pkgs, ... }:

{
  home.username = "artud";
  home.homeDirectory = "/home/artud";
  home.stateVersion = "26.05";

  # User-specific packages
  home.packages = with pkgs; [
    bruno
    lunatask
    actual-server
    qbittorrent
    plex
    slack
    telegram-desktop
    thunderbird
  ];

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  home.sessionVariables = {
    XCURSOR_SIZE = "24";
  };

  xdg.mimeApps.enable = true;
}

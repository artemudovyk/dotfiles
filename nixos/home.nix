{ pkgs, lib, ... }:

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

  xdg.configFile = {
    "niri".source = ../config/niri;
    "noctalia/config.toml".source = lib.mkForce ../config/noctalia/config.toml;
  };

  # Dark mode
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Adwaita-dark"; # or "Breeze-Dark"
    };
  };
  # GTK2/3/4 Dark Mode
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark"; # or "breeze-dark"
      package = pkgs.gnome-themes-extra;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
  # Qt Applications Dark Mode
  qt = {
    enable = true;
    platformTheme.name = "kde"; # Uses KDE Breeze style if available, or "gtk"
    # style.name = "breeze-dark";
  };
  home.sessionVariables = {
    # Force GTK apps to use dark theme variant
    GTK_THEME = "Adwaita-dark";
    # Force Qt apps to render with dark palette
    QT_QPA_PLATFORMTHEME = "kde"; # or "gtk2"
    QT_STYLE_OVERRIDE = "Breeze-Dark";
  };
}

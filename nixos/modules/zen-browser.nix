{ pkgs, inputs, ... }:

let
  desktopFile = "zen-beta.desktop";
in
{
  nixpkgs.overlays = [
    (final: prev: {
      zen-browser = inputs.zen-browser.packages.${prev.system}.default;
    })
  ];

  home-manager.sharedModules = [
    {
      home.packages = [
        pkgs.zen-browser
      ];

      xdg.mimeApps = {
        enable = true;
        defaultApplications = {
          "text/html" = desktopFile;
          "x-scheme-handler/http" = desktopFile;
          "x-scheme-handler/https" = desktopFile;
          "x-scheme-handler/about" = desktopFile;
          "x-scheme-handler/unknown" = desktopFile;
          "application/xhtml+xml" = desktopFile;
        };
      };

      programs.plasma = {
        configFile = {
          "kdeglobals"."General"."browserApplication" = desktopFile;
        };

        shortcuts = {
          "services/${desktopFile}"."_launch" = "Meta+B";
        };
      };
    }
  ];
}

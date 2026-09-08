{ pkgs, ... }:

{
  home-manager.sharedModules = [
    {
      programs.yazi = {
        enable = true;
        enableFishIntegration = true; # Automatically changes shell CWD on exit (press 'q')

        settings = {
          manager = {
            show_hidden = true;
            sort_by = "alphabetical";
          };
        };
      };

      home.packages = with pkgs; [
        ffmpegthumbnailer # Video previews
        p7zip # Archive previews (.zip, .7z, .tar)
        jq # JSON formatting in previews
        poppler # PDF previews
        fd # Fast file searching backend
        ripgrep # Content searching backend
        fzf # Quick fuzzy directory jumps
        zoxide # Smart directory jumping integration
      ];
      # -- HM
    }
  ];

}

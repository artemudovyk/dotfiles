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

        theme = {
          # Catppuccin Macchiato Palette Overrides
          manager = {
            cwd = {
              fg = "#8aadf4";
            }; # Blue
            hovered = {
              fg = "#cad3f5";
              bg = "#363a4f";
              bold = true;
            }; # Surface1
            preview_hovered = {
              bg = "#363a4f";
            };
          };
          status = {
            separator_style = {
              fg = "#24273a";
              bg = "#24273a";
            };
            mode_normal = {
              fg = "#181926";
              bg = "#8aadf4";
              bold = true;
            }; # Base / Blue
            mode_select = {
              fg = "#181926";
              bg = "#a6da95";
              bold = true;
            }; # Base / Green
            mode_unset = {
              fg = "#181926";
              bg = "#f5a97f";
              bold = true;
            }; # Base / Peach
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

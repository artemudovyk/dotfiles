{ pkgs, ... }:

{
  home-manager.sharedModules = [
    {
      programs.kitty = {
        enable = true;

        # Theme selection
        themeFile = "Catppuccin-Macchiato";

        # Key-value configuration mappings
        settings = {
          shell = "${pkgs.fish}/bin/fish";

          # Cursor trail animation settings
          cursor_trail = 3;
          cursor_trail_decay = "0.05 0.1";

          # Neovim scrollback pager configuration
          scrollback_pager = "nvim -c 'setlocal nonumber nolist showtabline=0 foldcolumn=0|Man!' -c \"autocmd VimEnter * normal G\" -";

          # Tab bar styling
          tab_bar_edge = "top";
          tab_bar_style = "powerline";
          tab_powerline_style = "angled";

          confirm_os_window_close = 0;
        };

        font = {
          name = "JetBrainsMono Nerd Font";
          # size = 11;
        };

        # Custom keybindings
        keybindings = {
          "ctrl+shift+1" = "goto_tab 1";
          "ctrl+shift+2" = "goto_tab 2";
          "ctrl+shift+3" = "goto_tab 3";
          "ctrl+shift+4" = "goto_tab 4";
          "ctrl+shift+5" = "goto_tab 5";
          "ctrl+shift+6" = "goto_tab 6";
          "ctrl+shift+7" = "goto_tab 7";
          "ctrl+shift+8" = "goto_tab 8";
          "ctrl+shift+9" = "goto_tab 9";
          "ctrl+shift+0" = "goto_tab 10";

          # Tab opening behavior
          "ctrl+shift+t" = "new_tab_with_cwd";

          # Unmap default unicode input shortcut
          "ctrl+shift+u" = "no_op";
        };
      };

      xdg.mimeApps = {
        defaultApplications = {
          "terminal" = "kitty.desktop";
        };
      };

      programs.plasma = {
        shortcuts = {
          "services/kitty.desktop"."_launch" = "Meta+Return";
        };
      };
    }
  ];
}

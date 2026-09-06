{ inputs, pkgs, ... }:

{
  # System-level requirements for Niri session target and PAM
  imports = [ inputs.niri.nixosModules.niri ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  # Essential Wayland graphics & portal permissions
  hardware.graphics.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
  };

  home-manager.sharedModules = [
    ({ config, ... }: {
      programs.niri.settings = {
        # ----------------------------------------------------------------------
        # Launch at startup
        # ----------------------------------------------------------------------
        spawn-at-startup = [
          {
            command = [
              "swayidle"
              "-w"
            ];
          }
          {
            command = [
              "dfr-theme-set-bg"
              "--keep-current"
            ];
          }
          { command = [ "mako" ]; }
          { command = [ "waybar" ]; }
          { command = [ "elephant" ]; }
          {
            command = [
              "walker"
              "--gapplication-service"
            ];
          }
          { command = [ "mpd" ]; }
          {
            command = [
              "sh"
              "-c"
              "sleep 1; exec mpd-mpris"
            ];
          }
          { command = [ "dfr-first-boot" ]; }
        ];

        # ----------------------------------------------------------------------
        # Input devices
        # ----------------------------------------------------------------------
        input = {
          keyboard = {
            xkb.options = "caps:swapescape,altwin:menu_win";
            repeat-delay = 200;
            repeat-rate = 40;
          };

          touchpad = {
            tap = true;
            natural-scroll = true;
            accel-profile = "flat";
          };

          mouse = {
            accel-profile = "flat";
            scroll-factor = 2.0;
          };
        };

        # ----------------------------------------------------------------------
        # Behaviors and aesthetics
        # ----------------------------------------------------------------------
        screenshot-path = null;

        hotkey-overlay.skip-at-startup = true;

        # gestures.hot-corners.off = true;

        prefer-no-csd = true;

        layout = {
          gaps = 8;
          focus-ring.width = 1;
        };

        # ----------------------------------------------------------------------
        # Window / layer rules
        # ----------------------------------------------------------------------
        window-rules = [
          {
            draw-border-with-background = false;
            geometry-corner-radius = {
              top-left = 2.0;
              top-right = 2.0;
              bottom-left = 2.0;
              bottom-right = 2.0;
            };
            clip-to-geometry = true;
          }
          {
            matches = [
              { app-id = "^Pinentry-gtk$"; }
              { app-id = "^Tk$"; }
              {
                app-id = "^gimp$";
                title = "Preferences";
              }
              { app-id = "^mpv$"; }
              {
                app-id = "^soffice$";
                title = "^Text Import";
              }
              {
                app-id = "^thunar$";
                title = "^Rename ";
              }
              {
                app-id = "^virt-manager$";
                title = " - Connection Details";
              }
              { app-id = "^wev$"; }
              { app-id = "^xarchiver$"; }
              {
                app-id = "firefox$";
                title = "^(Picture-in-Picture|Library|About Mozilla Firefox|Firefox - Choose a profile)$";
              }
            ];
            open-floating = true;
          }
          {
            matches = [
              { app-id = "^dfr\\.floating\\.ghostty$"; }
              { app-id = "^dfr\\.floating\\.thunar$"; }
            ];
            open-floating = true;
            default-column-width.proportion = 0.33;
            default-window-height.proportion = 0.5;
          }
          {
            matches = [
              { app-id = "^com\\.gabm\\.satty$"; }
            ];
            open-floating = true;
            min-width = 730;
            min-height = 300;
          }
          {
            matches = [
              { app-id = "^KeePassXC$"; }
            ];
            block-out-from = "screencast";
          }
        ];

        # ----------------------------------------------------------------------
        # Key binds
        # ----------------------------------------------------------------------
        binds = with config.lib.niri.actions; {
          # Overview
          "Mod+Grave".action = spawn "dfr-menu";
          "Mod+Slash".action = spawn "walker" "--height" "980" "--width" "980" "--provider" "menus:keybinds";
          "Mod+Shift+Slash".action =
            spawn "walker" "--height" "980" "--width" "980" "--provider"
              "niriactions";
          "Mod+Ctrl+Slash".action =
            spawn "walker" "--height" "980" "--width" "800" "--provider"
              "menus:waybar";
          "Mod+O" = {
            repeat = false;
            action = toggle-overview;
          };

          # System
          "Mod+Alt+L".action = spawn "swaylock";
          "Mod+Shift+Alt+L".action = power-off-monitors;
          "Mod+Ctrl+Shift+Q".action = quit;

          # Capture
          "Mod+S".action = spawn "dfr-screenshot" "region";
          "Mod+Shift+S".action = spawn "dfr-screenshot" "window";
          "Mod+Ctrl+S".action = spawn "dfr-screenshot" "monitor-focused";
          "Mod+Ctrl+Shift+S".action = spawn "dfr-screenshot" "monitor-all";

          "Mod+P".action =
            spawn "ghostty" "--class=dfr.floating.ghostty" "-e" "sh" "-c"
              "printf 'Pick a window...\n\n'; niri msg pick-window; niri msg action focus-window-previous; printf '\nDone! Press CTRL+c to quit\n'; read";
          "Mod+Shift+P".action =
            spawn "sh" "-c"
              "killall hyprpicker || hyprpicker --autocopy --lowercase-hex";

          "Mod+E".action =
            spawn "sh" "-c"
              "niri msg action set-dynamic-cast-window --id $(niri msg --json focused-window | jq .id)";

          # Notifications
          "Mod+N".action = spawn "makoctl" "restore";
          "Mod+Shift+N".action = spawn "makoctl" "dismiss";
          "Mod+Ctrl+N".action = spawn "makoctl" "dismiss" "--all";
          "Mod+Ctrl+Shift+N".action = spawn "dfr-toggle-notifications";

          # Themes
          "Mod+BackSlash".action = spawn "dfr-theme-set-bg";
          "Mod+Shift+BackSlash".action = spawn "dfr-theme-set-bg" "--menu";
          "Mod+Ctrl+BackSlash".action = spawn "dfr-theme-set";
          "Mod+Ctrl+Shift+BackSlash".action = spawn "dfr-theme-set" "--menu";

          # Media keys
          "XF86AudioRaiseVolume" = {
            allow-when-locked = true;
            action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05+";
          };
          "XF86AudioLowerVolume" = {
            allow-when-locked = true;
            action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05-";
          };
          "XF86AudioMute" = {
            allow-when-locked = true;
            action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
          };
          "XF86AudioMicMute" = {
            allow-when-locked = true;
            action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
          };

          "XF86AudioPlay" = {
            allow-when-locked = true;
            action = spawn "playerctl" "play-pause";
          };
          "XF86AudioStop" = {
            allow-when-locked = true;
            action = spawn "playerctl" "stop";
          };
          "XF86AudioPrev" = {
            allow-when-locked = true;
            action = spawn "playerctl" "previous";
          };
          "XF86AudioNext" = {
            allow-when-locked = true;
            action = spawn "playerctl" "next";
          };
          "Shift+XF86AudioPrev" = {
            allow-when-locked = true;
            action = spawn "playerctl" "position" "10-";
          };
          "Shift+XF86AudioNext" = {
            allow-when-locked = true;
            action = spawn "playerctl" "position" "10+";
          };

          "XF86MonBrightnessUp" = {
            allow-when-locked = true;
            action = spawn "brightnessctl" "--class=backlight" "set" "+5%";
          };
          "XF86MonBrightnessDown" = {
            allow-when-locked = true;
            action = spawn "brightnessctl" "--class=backlight" "set" "5%-";
          };

          "XF86Calculator" = {
            repeat = false;
            action = spawn "walker" "--provider" "calc";
          };

          # Launcher
          "Mod+Space".action = spawn "walker";
          "Mod+W" = {
            repeat = false;
            action = spawn "walker" "--provider" "windows";
          };
          "Mod+V" = {
            repeat = false;
            action = spawn "walker" "--provider" "clipboard";
          };

          # Apps
          "Mod+Alt+H".action = spawn "dfr-launch-or-focus-tui" "monitor";
          "Mod+Alt+T".action = spawn "ghostty";
          "Mod+Alt+Shift+T".action = spawn "ghostty" "--class=dfr.floating.ghostty";
          "Mod+Alt+F".action = spawn "thunar";
          "Mod+Alt+Shift+F".action = spawn "thunar" "--name=dfr.floating.thunar";
          "Mod+Alt+N".action = spawn "dfr-launch-or-focus-tui" "notes";
          "Mod+Alt+Shift+N".action = spawn "sh" "-c" "dfr-launch-or-focus-tui \${EDITOR} \${NOTES_DIRECTORY}";
          "Mod+Alt+P".action = spawn "dfr-launch-or-focus" "keepassxc";
          "Mod+Alt+Shift+P".action = spawn "pw";
          "Mod+Alt+M".action = spawn "dfr-launch-or-focus-tui" "rmpc";
          "Mod+Alt+B".action = spawn "firefox";
          "Mod+Alt+Shift+B".action = spawn "firefox" "-private-window";
          "Mod+Alt+Ctrl+Shift+B".action = spawn "sh" "-c" "firefox -P \${BROWSER_ISOLATED_PROFILE:-isolated}";

          # Display scaling
          "Mod+Ctrl+Shift+Equal".action = spawn "output-scale" "+";
          "Mod+Ctrl+Shift+Minus".action = spawn "output-scale" "-";
          "Mod+Ctrl+Shift+0".action = spawn "output-scale" "1.0";

          # Window and column behavior
          "Mod+Q" = {
            repeat = false;
            action = close-window;
          };

          "Mod+C".action = center-column;
          "Mod+Ctrl+C".action = center-visible-columns;

          "Mod+Z".action = toggle-window-floating;
          "Mod+Ctrl+Z".action = switch-focus-between-floating-and-tiling;

          "Mod+T".action = toggle-column-tabbed-display;

          "Mod+BracketLeft".action = consume-or-expel-window-left;
          "Mod+BracketRight".action = consume-or-expel-window-right;
          "Mod+Comma".action = consume-window-into-column;
          "Mod+Period".action = expel-window-from-column;

          # Window and column sizes
          "Mod+F".action = maximize-column;
          "Mod+Shift+F".action = fullscreen-window;
          "Mod+Ctrl+F".action = expand-column-to-available-width;

          "Mod+R".action = switch-preset-column-width;
          "Mod+Shift+R".action = switch-preset-window-height;
          "Mod+Ctrl+R".action = reset-window-height;

          "Mod+Equal".action = set-column-width "+10%";
          "Mod+Minus".action = set-column-width "-10%";
          "Mod+Shift+Equal".action = set-window-height "+10%";
          "Mod+Shift+Minus".action = set-window-height "-10%";

          # Window and column movement
          "Mod+I".action = focus-window-previous;

          "Mod+Left".action = focus-column-left;
          "Mod+Down".action = focus-window-down;
          "Mod+Up".action = focus-window-up;
          "Mod+Right".action = focus-column-right;
          "Mod+H".action = focus-column-left;
          "Mod+J".action = focus-window-down;
          "Mod+K".action = focus-window-up;
          "Mod+L".action = focus-column-right;

          "Mod+Ctrl+Left".action = move-column-left;
          "Mod+Ctrl+Down".action = move-window-down;
          "Mod+Ctrl+Up".action = move-window-up;
          "Mod+Ctrl+Right".action = move-column-right;
          "Mod+Ctrl+H".action = move-column-left;
          "Mod+Ctrl+J".action = move-window-down;
          "Mod+Ctrl+K".action = move-window-up;
          "Mod+Ctrl+L".action = move-column-right;

          "Mod+G".action = focus-column-first;
          "Mod+SemiColon".action = focus-column-last;
          "Mod+Ctrl+G".action = move-column-to-first;
          "Mod+Ctrl+SemiColon".action = move-column-to-last;
          "Mod+Home".action = focus-column-first;
          "Mod+End".action = focus-column-last;
          "Mod+Ctrl+Home".action = move-column-to-first;
          "Mod+Ctrl+End".action = move-column-to-last;

          "Mod+WheelScrollDown".action = focus-column-right;
          "Mod+WheelScrollUp".action = focus-column-left;
          "Mod+Ctrl+WheelScrollDown".action = move-column-right;
          "Mod+Ctrl+WheelScrollUp".action = move-column-left;
          "Mod+WheelScrollRight".action = focus-column-right;
          "Mod+WheelScrollLeft".action = focus-column-left;
          "Mod+Ctrl+WheelScrollRight".action = move-column-right;
          "Mod+Ctrl+WheelScrollLeft".action = move-column-left;

          # Multiple monitor movement
          "Mod+Ctrl+Shift+Left".action = move-column-to-monitor-left;
          "Mod+Ctrl+Shift+Down".action = move-column-to-monitor-down;
          "Mod+Ctrl+Shift+Up".action = move-column-to-monitor-up;
          "Mod+Ctrl+Shift+Right".action = move-column-to-monitor-right;
          "Mod+Ctrl+Shift+H".action = move-column-to-monitor-left;
          "Mod+Ctrl+Shift+J".action = move-column-to-monitor-down;
          "Mod+Ctrl+Shift+K".action = move-column-to-monitor-up;
          "Mod+Ctrl+Shift+L".action = move-column-to-monitor-right;

          "Mod+MouseBack".action = focus-monitor-left;
          "Mod+MouseForward".action = focus-monitor-right;
          "Mod+Ctrl+Shift+MouseBack".action = move-column-to-monitor-left;
          "Mod+Ctrl+Shift+MouseForward".action = move-column-to-monitor-right;

          # Workspaces
          "Mod+Shift+WheelScrollDown" = {
            cooldown-ms = 150;
            action = focus-workspace-down;
          };
          "Mod+Shift+WheelScrollUp" = {
            cooldown-ms = 150;
            action = focus-workspace-up;
          };
          "Mod+Ctrl+Shift+WheelScrollDown" = {
            cooldown-ms = 150;
            action = move-column-to-workspace-down;
          };
          "Mod+Ctrl+Shift+WheelScrollUp" = {
            cooldown-ms = 150;
            action = move-column-to-workspace-up;
          };

          "Mod+D".action = focus-workspace-down;
          "Mod+U".action = focus-workspace-up;
          "Mod+Page_Down".action = focus-workspace-down;
          "Mod+Page_Up".action = focus-workspace-up;
          "Mod+Ctrl+D".action = move-column-to-workspace-down;
          "Mod+Ctrl+U".action = move-column-to-workspace-up;
          "Mod+Ctrl+Page_Down".action = move-column-to-workspace-down;
          "Mod+Ctrl+Page_Up".action = move-column-to-workspace-up;
          "Mod+Shift+D".action = move-workspace-down;
          "Mod+Shift+U".action = move-workspace-up;
          "Mod+Shift+Page_Down".action = move-workspace-down;
          "Mod+Shift+Page_Up".action = move-workspace-up;

          "Mod+1".action = focus-workspace 1;
          "Mod+2".action = focus-workspace 2;
          "Mod+3".action = focus-workspace 3;
          "Mod+4".action = focus-workspace 4;
          "Mod+5".action = focus-workspace 5;
          "Mod+6".action = focus-workspace 6;
          "Mod+7".action = focus-workspace 7;
          "Mod+8".action = focus-workspace 8;
          "Mod+9".action = focus-workspace 9;

          # "Mod+Shift+1".action = move-window-to-workspace 1;
          # "Mod+Shift+2".action = move-window-to-workspace 2;
          # "Mod+Shift+3".action = move-window-to-workspace 3;
          # "Mod+Shift+4".action = move-window-to-workspace 4;
          # "Mod+Shift+5".action = move-window-to-workspace 5;
          # "Mod+Shift+6".action = move-window-to-workspace 6;
          # "Mod+Shift+7".action = move-window-to-workspace 7;
          # "Mod+Shift+8".action = move-window-to-workspace 8;
          # "Mod+Shift+9".action = move-window-to-workspace 9;

          # "Mod+Ctrl+1".action = move-column-to-workspace 1;
          # "Mod+Ctrl+2".action = move-column-to-workspace 2;
          # "Mod+Ctrl+3".action = move-column-to-workspace 3;
          # "Mod+Ctrl+4".action = move-column-to-workspace 4;
          # "Mod+Ctrl+5".action = move-column-to-workspace 5;
          # "Mod+Ctrl+6".action = move-column-to-workspace 6;
          # "Mod+Ctrl+7".action = move-column-to-workspace 7;
          # "Mod+Ctrl+8".action = move-column-to-workspace 8;
          # "Mod+Ctrl+9".action = move-column-to-workspace 9;

          # Escape hatch inhibitor
          "Mod+Escape" = {
            allow-inhibiting = false;
            action = toggle-keyboard-shortcuts-inhibit;
          };
        };
      };
    })
  ];
}

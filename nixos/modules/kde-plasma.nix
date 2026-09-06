{ pkgs, ... }:

{
  home-manager.sharedModules = [
    {
      home.packages = [
        pkgs.kdePackages.krohnkite
      ];

      programs.plasma = {
        enable = true;

        workspace = {
          # clickToOpenHasEffect = false; # Double-click to open files/folders
          lookAndFeel = "org.kde.breezedark.desktop";
          # cursor = {
          #   theme = "Breeze_Snow";
          #   size = 24;
          # };
        };

        kwin = {
          effects.shakeCursor.enable = false;
          effects.desktopSwitching.animation = "off";

          # scripts.polonium.enable = true;

          virtualDesktops = {
            number = 6;
            rows = 1;
            names = [
              "1"
              "2"
              "3"
              "4"
              "5"
              "6"
            ];
          };

          tiling.padding = 0;
        };

        # Polonium and KWin border configuration
        configFile = {
          # Force KDE Session Manager to start with a fresh/empty session
          # 2 = Start with an empty session
          # 0 = Restore previous session (disabled)
          # 1 = Restore manually saved session
          "ksmserverrc"."General"."loginMode" = "emptySession";

          # Enable Krohnkite script engine in KWin
          "kwinrc"."Plugins"."krohnkiteEnabled" = true;
          # Force KWin to strictly enforce panel strut constraints
          # Tell Krohnkite not to dynamically readjust for docks since top space is reserved
          # "kwinrc"."Script-krohnkite"."ignoreDock" = true;
          # Sole Window Properties (Single window on desktop)
          "kwinrc"."Script-krohnkite"."monocleMaximize" = true; # No Borders / Maximize sole window
          "kwinrc"."Script-krohnkite"."monocleNoGap" = true; # No Gaps for sole window
          # Force gaps globally across all virtual desktops
          "kwinrc"."Script-krohnkite"."screenGapBetween" = 3;
          "kwinrc"."Script-krohnkite"."screenGapOuter" = 3;
          "kwinrc"."Script-krohnkite"."borderLayout" = 3; # 0 = no borders on tiled windows
          # "kwinrc"."Script-krohnkite"."screenGapTop" = 0;

          # Focus Follows Mouse configuration
          "kwinrc"."Windows"."FocusPolicy" = "FocusFollowsMouse";
          "kwinrc"."Windows"."NextFocusPrefersMouse" = true;
          "kwinrc"."Windows"."DelayFocusInterval" = 0;
          # Optional: Set auto-raise behavior (false keeps active window in background until clicked)
          "kwinrc"."Windows"."AutoRaise" = false;
          "kwinrc"."Windows"."AutoRaiseInterval" = 0;

          # Strip window decorations globally
          "kwinrulesrc"."1"."description" = "Strip window decorations";
          "kwinrulesrc"."1"."wmclasscomplete" = false;
          "kwinrulesrc"."1"."types" = 1; # Normal windows
          "kwinrulesrc"."1"."noborder" = true;
          "kwinrulesrc"."1"."noborderrule" = 2; # Force
          "kwinrulesrc"."General"."count" = 1;
          "kwinrulesrc"."General"."rules" = "1";

          # Disable hot corners
          "kwinrc"."Effect-overview"."BorderActivate" = 9;
          "kwinrc"."ElectricBorders"."Top" = "None";
          "kwinrc"."ElectricBorders"."TopRight" = "None";
          "kwinrc"."ElectricBorders"."Right" = "None";
          "kwinrc"."ElectricBorders"."BottomRight" = "None";
          "kwinrc"."ElectricBorders"."Bottom" = "None";
          "kwinrc"."ElectricBorders"."BottomLeft" = "None";
          "kwinrc"."ElectricBorders"."Left" = "None";
          "kwinrc"."ElectricBorders"."TopLeft" = "None";
          "kwinrc"."TouchEdges"."Top" = "None";
          "kwinrc"."TouchEdges"."Right" = "None";
          "kwinrc"."TouchEdges"."Bottom" = "None";
          "kwinrc"."TouchEdges"."Left" = "None";

          # Disable cursor bounce animation when launching applications
          "klaunchrc"."FeedbackStyle"."BusyCursor" = false;
          # Optional: Disable the taskbar progress animation as well
          "klaunchrc"."FeedbackStyle"."TaskbarButton" = false;

          # Disable On-Screen Display popups
          # "plasmarc"."OSD"."Enabled" = false;

          # Disable audio feedbacks
          "plasmaparc"."General"."AudioFeedback" = false;
          "plasmaparc"."General"."DefaultOutputDeviceOsd" = false;
          "plasmaparc"."General"."MicrophoneSensitivityOsd" = false;
          "plasmaparc"."General"."MuteOsd" = false;
          "plasmaparc"."General"."MutedMicrophoneReminderOsd" = false;
          "plasmaparc"."General"."PushToTalkOsd" = false;
          "plasmaparc"."General"."VolumeOsd" = true;

        };

        window-rules = [
          {
            description = "Disable window decorations for single/tiled windows";
            match = {
              window-types = [ "normal" ];
            };
            apply = {
              no-border = {
                value = true;
                apply = "force";
              };
            };
          }
        ];

        krunner = {
          position = "center";
        };

        kscreenlocker = {
          autoLock = false;
          timeout = 0;
          lockOnResume = false;
        };

        input.keyboard = {
          layouts = [
            { layout = "pl"; }
            { layout = "ua"; }
          ];
          # XKB options for toggling (e.g., Alt+Shift or Win+Space)
          options = [ "grp:alt_shift_toggle" ];
          # Options: "global", "desktop", "winClass", or "window"
          switchingPolicy = "global";
        };

        powerdevil = {
          AC = {
            autoSuspend.action = "nothing";
            dimDisplay.enable = false;
            dimKeyboard.enable = false;
            powerButtonAction = "nothing";
            powerProfile = "performance";
          };
        };

        panels = [
          {
            location = "top";
            height = 20;

            widgets = [
              # --- LEFT SIDE ---
              # Kickoff Launcher with a Custom Icon
              {
                name = "org.kde.plasma.kickoff";
                config = {
                  General = {
                    # Use a standard system icon name, or a full path to an SVG/PNG
                    icon = "nix-snowflake";
                  };
                };
              }

              # Desktop Pager (Virtual Desktops switcher)
              "org.kde.plasma.pager"

              # Icons-Only Task Manager (Configured to NOT group applications)
              {
                name = "org.kde.plasma.icontasks";
                config = {
                  General = {
                    # 0 = Do not group (shows separate icon entry per window instance)
                    groupingStrategy = 0;
                    # Setting launchers/apps to empty removes all default pins
                    launchers = [ ];
                  };
                };
              }

              # --- CENTER ---
              # Spacer that expands to push subsequent widgets to center
              "org.kde.plasma.panelspacer"

              # Active Window Title
              {
                name = "org.kde.plasma.activewindow";
                config = {
                  General = {
                    showAppName = true;
                    showWindowTitle = true;
                    showActivityName = false;
                  };
                };
              }

              # Spacer that expands to push remaining widgets to the far right
              "org.kde.plasma.panelspacer"

              # --- RIGHT SIDE ---
              "org.kde.plasma.systemtray"
              {
                name = "org.kde.plasma.digitalclock";
                config = {
                  Appearance = {
                    showDate = false; # Hides the date display completely
                    dateFormat = "custom";
                    use24hFormat = 2; # 2 = Force 24-hour clock format (e.g., 19:19)
                    showSeconds = "never"; # Options: "never", "always", "small"
                  };
                };
              }
            ];
          }
        ];

        shortcuts = {
          # System & KWin Actions
          "kwin"."Window Close" = "Meta+Q";
          "kwin"."Toggle Night Color" = "Meta+N";
          "kwin"."Overview" = "Meta+W";
          "ksmserver"."Lock Session" = "Meta+L";

          # Disable single Meta key triggering the Application Launcher / Kickoff
          "plasmashell"."activate widget 1" = "none";
          "plasmashell"."activate application launcher" = "none";

          # CLEAR the conflicting Task Manager shortcuts in plasmashell
          "plasmashell"."activate task manager entry 1" = "none";
          "plasmashell"."activate task manager entry 2" = "none";
          "plasmashell"."activate task manager entry 3" = "none";
          "plasmashell"."activate task manager entry 4" = "none";
          "plasmashell"."activate task manager entry 5" = "none";
          "plasmashell"."activate task manager entry 6" = "none";
          "plasmashell"."activate task manager entry 7" = "none";
          "plasmashell"."activate task manager entry 8" = "none";
          "plasmashell"."activate task manager entry 9" = "none";
          "plasmashell"."activate task manager entry 10" = "none";

          # Clear shifted Task Manager launch actions
          "plasmashell"."launch new instance 1" = "none";
          "plasmashell"."launch new instance 2" = "none";
          "plasmashell"."launch new instance 3" = "none";
          "plasmashell"."launch new instance 4" = "none";
          "plasmashell"."launch new instance 5" = "none";
          "plasmashell"."launch new instance 6" = "none";
          "plasmashell"."launch new instance 7" = "none";
          "plasmashell"."launch new instance 8" = "none";
          "plasmashell"."launch new instance 9" = "none";
          "plasmashell"."launch new instance 10" = "none";

          # Map Meta+1..6 to switch directly to each desktop
          "kwin"."Switch to Desktop 1" = "Meta+1";
          "kwin"."Switch to Desktop 2" = "Meta+2";
          "kwin"."Switch to Desktop 3" = "Meta+3";
          "kwin"."Switch to Desktop 4" = "Meta+4";
          "kwin"."Switch to Desktop 5" = "Meta+5";
          "kwin"."Switch to Desktop 6" = "Meta+6";
          "kwin"."Switch to Desktop 7" = "Meta+7";
          "kwin"."Switch to Desktop 8" = "Meta+8";
          "kwin"."Switch to Desktop 9" = "Meta+9";
          "kwin"."Switch to Desktop 10" = "Meta+0";

          # Application Launchers
          # 1. Clear Power Profile holding Meta+B
          "org_kde_powerdevil"."powerProfile" = "none";
          "org_kde_powerdevil"."Switch Power Profile" = "none";
          "Power Management"."powerProfile" = "none";

          # 2. Clear Krohnkite CamelCase key holding Meta+Return
          "kwin"."KrohnkiteSetMaster" = "none";
          "kwin"."Krohnkite: Set master" = "none";

          # 3. Clear Konsole launchers
          "services/org.kde.konsole.desktop"."_launch" = "none";
          "services/konsole.desktop"."_launch" = "none";

          "services/org.kde.krunner.desktop"."_launch" = "Meta+R";
          "krunner.desktop"."_launch" = "Meta+R"; # Disable default Meta+Space for KRunner

          # Move Window to Desktop (Use shifted symbols instead of Shift+Number)
          "kwin"."Window to Desktop 1" = "Meta+!";
          "kwin"."Window to Desktop 2" = "Meta+@";
          "kwin"."Window to Desktop 3" = "Meta+#";
          "kwin"."Window to Desktop 4" = "Meta+$";
          "kwin"."Window to Desktop 5" = "Meta+%";
          "kwin"."Window to Desktop 6" = "Meta+^";
          "kwin"."Window to Desktop 7" = "Meta+&";
          "kwin"."Window to Desktop 8" = "Meta+*";
          "kwin"."Window to Desktop 9" = "Meta+(";
          "kwin"."Window to Desktop 0" = "Meta+)";

          "kwin"."Window Fullscreen" = "Meta+F";

          # Clear Spectacle's Meta+R recording binding
          "org.kde.spectacle.desktop"."RecordRegion" = "none";
          "org.kde.spectacle.desktop"."RecordScreen" = "none";
          # Map Spectacle capture actions to PrintScreen
          "org.kde.spectacle.desktop"."_launch" = "Print";
          "org.kde.spectacle.desktop"."RectangularRegionScreenShot" = "Print";
          "org.kde.spectacle.desktop"."CaptureEntireDesktop" = "Shift+Print";

          # Unbind KWin effects attached to screen corners
          "kwin"."ElectricBorderOverview" = "none";
          "kwin"."ElectricBorderShowDesktop" = "none";
          "kwin"."ElectricBorderDesktopGrid" = "none";
          "kwin"."ShowDesktopGrid" = "none";
        };
      };

      # Autostart
      # Create an autostart desktop entry for session launch
      home.file.".config/autostart/init-workspace.desktop".text = ''
        [Desktop Entry]
        Type=Application
        Name=Initialize Workspace
        Comment=Switch to Virtual Desktop 1
        Exec=sh -c "qdbus org.kde.KWin /KWin org.kde.KWin.setCurrentDesktop 1"
        StartupNotify=false
        Terminal=false
      '';
      # Exec=sh -c "qdbus org.kde.KWin /KWin org.kde.KWin.setCurrentDesktop 1 && kitty"

      home.pointerCursor = {
        gtk.enable = true;
        x11.enable = true;
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
        size = 24;
      };

      # Ensures XCursor settings are written to ~/.Xresources / ~/.icons
      xresources.properties = {
        "Xcursor.size" = 24;
        "Xcursor.theme" = "Adwaita";
      };
    }
  ];
}

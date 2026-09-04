{ config, pkgs, ... }:

{
  home.username = "artud";
  home.homeDirectory = "/home/artud";

  home.stateVersion = "26.05";

  # User-specific packages
  home.packages = with pkgs; [
    git

    bruno
    rust-analyzer
    lua-language-server
    stylua
    ruff
    prettierd
    terraform-ls
    tree-sitter
    opencode

    # Nix
    nil # Nix LSP
    nixfmt
    statix
    deadnix

    pkgs.zen-browser
    pkgs.kdePackages.krohnkite
    lunatask
    actual-server
    qbittorrent
    plex
    slack
    telegram-desktop
    thunderbird

    gcc
    gnumake
    unzip
    gnutar
    curl
  ];

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # Neovim
  # Out-of-store symlink for Neovim
  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/nvim";
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    sideloadInitLua = true;
  };

  # Set Zen as default web browser and handler
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "zen-beta.desktop";
      "x-scheme-handler/http" = "zen-beta.desktop";
      "x-scheme-handler/https" = "zen-beta.desktop";
      "x-scheme-handler/about" = "zen-beta.desktop";
      "x-scheme-handler/unknown" = "zen-beta.desktop";
      "application/xhtml+xml" = "zen-beta.desktop";
      "terminal" = "kitty.desktop";
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

  # KDE Plasma
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

      # Make Zen-Beta a default browser in KDE settings
      "kdeglobals"."General"."browserApplication" = "zen-beta.desktop";

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

    # hotkeys.commands = {
    #   launch-brave = {
    #     name = "Launch Firefox";
    #     key = "Alt+B";
    #     command = "firefox";
    #   };
    #   launch-kitty = {
    #     name = "Launch Kitty";
    #     key = "Alt+Return";
    #     command = "kitty";
    #   };
    # };

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

      # 4. Custom Launchers
      # TODO: remove later
      "services/firefox.desktop"."_launch" = "none";
      "services/zen-beta.desktop"."_launch" = "Meta+B";
      "services/kitty.desktop"."_launch" = "Meta+Return";

      "services/org.kde.krunner.desktop"."_launch" = "Meta+R";
      "krunner.desktop"."_launch" = "Meta+R"; # Disable default Meta+Space for KRunner

      # Polonium Tiling Shortcuts
      "kwin"."Polonium.Retile" = "Meta+\\";
      "kwin"."Polonium.FocusLeft" = "Meta+H";
      "kwin"."Polonium.FocusDown" = "Meta+J";
      "kwin"."Polonium.FocusUp" = "Meta+K";
      "kwin"."Polonium.FocusRight" = "Meta+L";
      "kwin"."Polonium.OpenSettings" = "Meta+Shift+K";

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

    shellIntegration = {
      enableFishIntegration = true;
    };
  };

  programs.ssh = {
    enable = true;

    enableDefaultConfig = false;

    settings = {
      # "*" = {
      #   AddKeysToAgent = "yes";
      #   IdentityAgent = "none";
      # };

      "github.com" = {
        hostname = "github.com";
        identityFile = "~/.ssh/id_udovyk";
        identitiesOnly = true;
        IdentityAgent = "none";
      };

      "udovyk.github.com" = {
        hostname = "github.com";
        identityFile = "~/.ssh/id_udovyk";
        identitiesOnly = true;
        IdentityAgent = "none";
      };

      "konstankino.github.com" = {
        hostname = "github.com";
        identityFile = "~/.ssh/id_konstankino";
        identitiesOnly = true;
        IdentityAgent = "none";
      };

      "kk.github.com" = {
        hostname = "github.com";
        identityFile = "~/.ssh/id_konstankino";
        identitiesOnly = true;
        IdentityAgent = "none";
      };

      "bitbucket.org" = {
        hostname = "bitbucket.org";
        identityFile = "~/.ssh/id_konstankino_tmp_bitbucket";
        identitiesOnly = true;
        IdentityAgent = "none";
      };
    };
  };

  programs.git = {
    enable = true;
    settings.user.name = "Artem Udovyk";
    settings.user.email = "artem@udovyk.com";

    # Automatically swap Git profile based on project path
    includes = [
      {
        condition = "gitdir:~/dev/";
        contents = {
          user.name = "Artem Udovyk";
          user.email = "artem@udovyk.com";
          # core.sshCommand = "ssh -i ~/.ssh/id_udovyk -o IdentitiesOnly=yes";
        };
      }
      {
        condition = "gitdir:~/dev/konstankino/";
        contents = {
          user.name = "Artem Udovyk";
          user.email = "udovyk.a@konstankino.com";
          # core.sshCommand = "ssh -i ~/.ssh/id_konstankino -o IdentitiesOnly=yes";
        };
      }
    ];

    settings = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    defaultSopsFile = ./secrets/ssh-keys.yaml;

    secrets = {
      id_udovyk = {
        path = "${config.home.homeDirectory}/.ssh/id_udovyk";
        mode = "0600";
      };
      id_konstankino = {
        path = "${config.home.homeDirectory}/.ssh/id_konstankino";
        mode = "0600";
      };
      id_konstankino_tmp_bitbucket = {
        path = "${config.home.homeDirectory}/.ssh/id_konstankino_tmp_bitbucket ";
        mode = "0600";
      };
    };
  };

  home.file = {
    ".ssh/id_udovyk.pub".text = ''
      ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICHgbOne7K3p42oA7/+p4ZLru7aZmO8/M75aDJqbiVIN udovyk@gmail.com
    '';

    ".ssh/id_konstankino.pub".text = ''
      ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICnYVTOHFunfpfNtCtcJeQD8JdSGD4SgW5YLFg4qziqy udovyk.a@konstankino.com
    '';

    ".ssh/id_konstankino_tmp_bitbucket.pub".text = ''
      ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKSF2G6kA2dfLlxedDHQP0EZsrkH7safSoaDOdJVGnHS udovyk.a@konstankino.com
    '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      # Disable interactive greeting
      set fish_greeting
    '';

    shellAliases = {
      lg = "lazygit";
      ld = "lazydocker";
      v = "nvim";
      nrs = "sudo nixos-rebuild switch --flake ~/dotfiles/nixos/.#nixos";
      nrt = "sudo nixos-rebuild test --flake ~/dotfiles/nixos/.#nixos";
      nrb = "sudo nixos-rebuild boot --flake ~/dotfiles/nixos/.#nixos";
    };

    functions = {
      nix = ''
        if test "$argv[1]" = "shell"
          IN_NIX_SHELL=impure command nix $argv
        else
          command nix $argv
        end
      '';
    };
  };

  programs.starship = {
    enable = true;

    enableFishIntegration = true;

    settings = {
      add_newline = true;

      line_break = {
        disabled = false;
      };

      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
      };

      nix_shell = {
        symbol = "❄️ ";
        impure_msg = "impure";
        pure_msg = "pure";
        unknown_msg = "";
        format = "via [$symbol$state]($style) ";
      };
    };
  };

  # Lazygit configuration
  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        showIcons = true;
      };
      git = {
        paging = {
          colorArg = "always";
          pager = "delta --dark --paging=never";
        };
      };
    };
  };

  # Lazydocker configuration
  programs.lazydocker = {
    enable = true;
    settings = {
      gui = {
        showBottomLine = true;
      };
    };
  };
}

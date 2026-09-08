{ pkgs, inputs, ... }:

let
  toggleDisplay = pkgs.writeShellApplication {
    name = "toggle-display";

    runtimeInputs = with pkgs; [
      wlr-randr
      libnotify
      gnugrep
      gawk
      coreutils
    ];

    text = ''
      # 1. Dynamically list all connected outputs (e.g. DP-1, HDMI-A-1)
      MAPFILE=()
      while IFS= read -r line; do
        MAPFILE+=("$line")
      done < <(wlr-randr | awk '/^[A-Za-z0-9-]+ "/ {print $1}')

      NUM_OUTPUTS=''${#MAPFILE[@]}

      if [ "$NUM_OUTPUTS" -lt 2 ]; then
        notify-send "Display Switch" "Only 1 display detected ($NUM_OUTPUTS active)."
        exit 0
      fi

      # 2. Find currently active display index
      CURRENT_INDEX=-1
      for i in "''${!MAPFILE[@]}"; do
        OUTPUT="''${MAPFILE[$i]}"
        if wlr-randr | grep -A 10 "^$OUTPUT " | grep -q "Enabled: yes"; then
          CURRENT_INDEX=$i
          break
        fi
      done

      # 3. Determine next display in cycle
      NEXT_INDEX=$(( (CURRENT_INDEX + 1) % NUM_OUTPUTS ))
      NEXT_OUTPUT="''${MAPFILE[$NEXT_INDEX]}"

      # 4. Turn off all displays except the next one
      CMD=(wlr-randr)
      for OUTPUT in "''${MAPFILE[@]}"; do
        if [ "$OUTPUT" == "$NEXT_OUTPUT" ]; then
          CMD+=(--output "$OUTPUT" --on)
        else
          CMD+=(--output "$OUTPUT" --off)
        fi
      done

      # Execute dynamic toggle command
      "''${CMD[@]}"
      notify-send "Display Switch" "Switched to output: $NEXT_OUTPUT"
    '';
  };
in
{

  imports = [
    inputs.noctalia-greeter.nixosModules.default
  ];

  programs.niri = {
    enable = true;
  };

  # programs.noctalia-greeter = {
  #   enable = true;
  # };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true; # Ensures SDDM runs natively under Wayland
    theme = "breeze"; # Optional: use breeze or custom theme
  };

  home-manager.sharedModules = [
    {
      imports = [
        inputs.noctalia.homeModules.default
        inputs.walker.homeManagerModules.default
      ];

      home.packages = with pkgs; [
        toggleDisplay
        playerctl
        brightnessctl
        calc
        grim # Wayland screenshot utility
        slurp # Region selection tool
        satty # Annotation GUI (Catppuccin compatible)
        wl-clipboard
        gpu-screen-recorder # CLI / Backend
        gpu-screen-recorder-gtk # GTK Tray / GUI (Spectacle-like recorder window)
        xwayland-satellite
        xwayland
      ];

      programs.noctalia = {
        enable = true;
      };

      programs.walker = {
        enable = true;
        runAsService = true;

        config = {
          placeholder = "Search or type command...";
          show_sub_when_single = true;

          # Vim keybindings for list navigation
          keybinds = {
            # Navigation
            next = [
              "Down"
              "ctrl n"
              "ctrl j"
            ];
            previous = [
              "Up"
              "ctrl p"
              "ctrl k"
            ];

            # Accept
            accept_type = [ "Return" ];

            # Close (Use Capitalized "Escape" or "ctrl c")
            close = [
              "Escape"
              "ctrl c"
            ];
          };
        };
      };

      services.swayidle = {
        enable = true;
        timeouts = [
          {
            # Turn off monitors after 10 minutes (600 seconds) of inactivity
            timeout = 600;
            command = "${pkgs.niri}/bin/niri msg action power-off-monitors";
            # Turn monitors back on immediately when mouse/keyboard input is detected
            resumeCommand = "${pkgs.niri}/bin/niri msg action power-on-monitors";
          }
        ];
      };
      # -- HM
    }
  ];
}

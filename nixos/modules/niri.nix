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
    useNautilus = true;
  };

  programs.noctalia-greeter = {
    enable = true;
  };

  home-manager.sharedModules = [
    {
      imports = [
        inputs.noctalia.homeModules.default
        inputs.walker.homeManagerModules.default
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
        };
      };

      home.packages = [ toggleDisplay ];
      # -- HM
    }
  ];
}

{ ... }:

{
  home-manager.sharedModules = [
    {
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

          # nix_shell = {
          #   symbol = "❄️ ";
          #   impure_msg = "impure";
          #   pure_msg = "pure";
          #   unknown_msg = "";
          #   format = "via [$symbol$state]($style) ";
          # };
        };
      };
    }
  ];
}

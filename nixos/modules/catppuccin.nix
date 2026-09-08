{ inputs, ... }:

{
  home-manager.sharedModules = [
    {
      imports = [
        inputs.catppuccin.homeModules.catppuccin
      ];

      catppuccin = {
        enable = true;
        autoEnable = false;

        flavor = "macchiato";
        accent = "blue";

        yazi = {
          enable = true;
        };
      };
      # -- HM
    }
  ];
}

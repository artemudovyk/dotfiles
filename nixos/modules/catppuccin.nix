{ inputs, ... }:

{
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  home-manager.sharedModules = [
    {
      catppuccin.yazi = {
        enable = true;
        flavor = "macchiato";
      };
      # -- HM
    }
  ];
}

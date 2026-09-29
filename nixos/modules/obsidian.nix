{ pkgs, ... }:

{
  home-manager.sharedModules = [
    {
      programs.obsidian = {
        enable = true;
        package = pkgs.obsidian;
      };
    }
  ];
}

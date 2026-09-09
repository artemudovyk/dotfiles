{ ... }:

{
  home-manager.sharedModules = [
    {
      programs.obsidian = {
        enable = true;
      };
    }
  ];
}

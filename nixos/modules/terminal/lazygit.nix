{ ... }:

{
  home-manager.sharedModules = [
    {
      programs.lazygit = {
        enable = true;
      };
    }
  ];
}

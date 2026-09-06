{ ... }:

{
  home-manager.sharedModules = [
    {
      programs.lazydocker = {
        enable = true;
        settings = {
          gui = {
            showBottomLine = true;
          };
        };
      };
    }
  ];
}

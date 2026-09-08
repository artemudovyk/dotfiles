{
  inputs,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    (inputs.import-tree.filterNot (lib.hasSuffix "default.nix") ./.)
  ];

  home-manager.sharedModules = [
    {
      home.packages = with pkgs; [
        fd # Fast file searching backend
        ripgrep # Content searching backend
        zoxide # Smart directory jumping integration
      ];

      programs.fzf = {
        enable = true;
        enableFishIntegration = true;
      };

      programs.carapace = {
        enable = true;
        enableFishIntegration = true;
        ignoreCase = true;
      };
    }
  ];
}

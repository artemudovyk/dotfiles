{ ... }:

{
  home-manager.sharedModules = [
    ({ config, ... }: {
      sops = {
        age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
      };
    })
  ];
}

{ ... }:

{
  home-manager.sharedModules = [
    {
      programs.fish = {
        enable = true;

        interactiveShellInit = ''
          # Disable interactive greeting
          set fish_greeting
        '';

        shellAliases = {
          lg = "lazygit";
          ld = "lazydocker";
          v = "nvim";
          nrs = "sudo nixos-rebuild switch --flake ~/dotfiles/nixos/.#desktop";
          nrt = "sudo nixos-rebuild test --flake ~/dotfiles/nixos/.#desktop";
          nrb = "sudo nixos-rebuild build --flake ~/dotfiles/nixos/.#desktop";
          nrdb = "sudo nixos-rebuild dry-build --flake ~/dotfiles/nixos/.#desktop";
        };

        functions = {
          nix = ''
            if test "$argv[1]" = "shell"
              IN_NIX_SHELL=impure command nix $argv
            else
              command nix $argv
            end
          '';
        };
      };

      programs.kitty = {
        shellIntegration = {
          enableFishIntegration = true;
        };
      };
    }
  ];
}

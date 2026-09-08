{ ... }:

{
  home-manager.sharedModules = [
    {
      programs.fish = {
        enable = true;

        interactiveShellInit = ''
          # Disable interactive greeting
          set fish_greeting

          # Enable Vim motions for terminal prompts
          fish_vi_key_bindings

          # Enable hjkl in Fish completion pager
          bind -M insert h 'if commandline --paging-mode; commandline -f backward-char; else; commandline -i h; end'
          bind -M insert j 'if commandline --paging-mode; commandline -f down-line; else; commandline -i j; end'
          bind -M insert k 'if commandline --paging-mode; commandline -f up-line; else; commandline -i k; end'
          bind -M insert l 'if commandline --paging-mode; commandline -f forward-char; else; commandline -i l; end'
        '';

        shellAliases = {
          lg = "lazygit";
          ld = "lazydocker";
          v = "nvim";
          nd = "nix develop --command $SHELL";
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

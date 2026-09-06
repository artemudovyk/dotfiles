{ pkgs, ... }:

{
  home-manager.sharedModules = [
    ({ config, ... }: {
      home.packages = with pkgs; [
        rust-analyzer
        lua-language-server
        stylua
        ruff
        prettierd
        terraform-ls
        tree-sitter
        # Nix
        nil # Nix LSP
        nixfmt
        statix
        deadnix

        ripgrep

        gcc
        gnumake
        unzip
        gnutar
        curl
        xdg-utils
      ];

      home.file.".config/nvim".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/nvim";

      programs.neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
        sideloadInitLua = true;
      };

      home.sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
      };
    })
  ];
}

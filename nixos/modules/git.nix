{ ... }:

{
  home-manager.sharedModules = [
    ({ config, ... }: {
      programs.git = {
        enable = true;
        settings.user.name = "Artem Udovyk";
        settings.user.email = "artem@udovyk.com";

        # Automatically swap Git profile based on project path
        includes = [
          {
            condition = "gitdir:~/dev/";
            contents = {
              user.name = "Artem Udovyk";
              user.email = "artem@udovyk.com";
            };
          }
          {
            condition = "gitdir:~/dev/konstankino/";
            contents = {
              user.name = "Artem Udovyk";
              user.email = "udovyk.a@konstankino.com";
            };
          }
        ];

        settings = {
          init.defaultBranch = "main";
          pull.rebase = true;
        };

        ignores = [
          ".direnv"
          ".envrc.local"
        ];
      };

      programs.ssh = {
        enable = true;

        enableDefaultConfig = false;

        settings = {
          # "*" = {
          #   AddKeysToAgent = "yes";
          #   IdentityAgent = "none";
          # };

          "github.com" = {
            hostname = "github.com";
            identityFile = "~/.ssh/id_udovyk";
            identitiesOnly = true;
            IdentityAgent = "none";
          };

          "udovyk.github.com" = {
            hostname = "github.com";
            identityFile = "~/.ssh/id_udovyk";
            identitiesOnly = true;
            IdentityAgent = "none";
          };

          "konstankino.github.com" = {
            hostname = "github.com";
            identityFile = "~/.ssh/id_konstankino";
            identitiesOnly = true;
            IdentityAgent = "none";
          };

          "kk.github.com" = {
            hostname = "github.com";
            identityFile = "~/.ssh/id_konstankino";
            identitiesOnly = true;
            IdentityAgent = "none";
          };

          "bitbucket.org" = {
            hostname = "bitbucket.org";
            identityFile = "~/.ssh/id_konstankino_tmp_bitbucket";
            identitiesOnly = true;
            IdentityAgent = "none";
          };
        };
      };

      home.file = {
        ".ssh/id_udovyk.pub".text = ''
          ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICHgbOne7K3p42oA7/+p4ZLru7aZmO8/M75aDJqbiVIN udovyk@gmail.com
        '';

        ".ssh/id_konstankino.pub".text = ''
          ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICnYVTOHFunfpfNtCtcJeQD8JdSGD4SgW5YLFg4qziqy udovyk.a@konstankino.com
        '';

        ".ssh/id_konstankino_tmp_bitbucket.pub".text = ''
          ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKSF2G6kA2dfLlxedDHQP0EZsrkH7safSoaDOdJVGnHS udovyk.a@konstankino.com
        '';
      };

      sops = {
        age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
        defaultSopsFile = ../secrets/ssh-keys.yaml;

        secrets = {
          id_udovyk = {
            path = "${config.home.homeDirectory}/.ssh/id_udovyk";
            mode = "0600";
          };
          id_konstankino = {
            path = "${config.home.homeDirectory}/.ssh/id_konstankino";
            mode = "0600";
          };
          id_konstankino_tmp_bitbucket = {
            path = "${config.home.homeDirectory}/.ssh/id_konstankino_tmp_bitbucket ";
            mode = "0600";
          };
        };
      };

    })
  ];
}

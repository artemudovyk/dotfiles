{ pkgs, ... }:

{
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
}

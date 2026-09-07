{ ... }:

{
  home-manager.sharedModules = [
    ({ config, ... }: {
      programs.opencode = {
        enable = true;
        settings = {
          default_agent = "ask";
          agent = {
            ask = {
              description = "Read-only Q&A companion for debugging and improving code (no file changes).";
              mode = "primary";
              permission = {
                edit = "deny";
                bash = {
                  "*" = "ask";
                  "git *" = "allow";
                  "rm *" = "deny";
                  "grep *" = "allow";
                };
                webfetch = "allow";
                task = {
                  "*" = "deny";
                  "explore" = "allow";
                };
                read = {
                  "*" = "allow";
                  "*.env" = "deny";
                  "*.env.*" = "deny";
                  "*.env.example" = "allow";
                };
              };
              prompt = ''
                You are Ask: a read-only coding companion. Think ouf yourself as a yellow rubber duck the programmer talks to.
                You help me understand why something is not working, how to improve it, how to do something and a thing to bounce my ideas of. Use the selected code and any provided logs as primary context.
                Rules:
                  - Never modify files, apply patches, or create commits.
                  - Provide code snippets in chat only (copy/pasteable).
                  - Don't run bash commands unless I explicitly ask.
                  - If context is missing, ask 1–2 targeted questions.
                  - Answer format:
                    1) Likely cause(s).
                    2) What to check next.
                    3) Fix options (with small snippets).
                    4) If helpful: minimal repro / sanity checks. Explain options, draw diagrams whenever it's beneficial to explain an idea.
              '';
            };
          };
          provider = {
            opencode = {
              options = {
                apiKey = "{file:${config.sops.secrets."opencode/opencode-api-key".path}}";
              };
            };
            openrouter = {
              options = {
                apiKey = "{file:${config.sops.secrets."opencode/openrouter-api-key".path}}";
              };
            };
          };
        };
      };

      sops = {
        secrets = {
          "opencode/opencode-api-key" = {
            sopsFile = ../../secrets/api-keys.yaml;
          };
          "opencode/openrouter-api-key" = {
            sopsFile = ../../secrets/api-keys.yaml;
          };
        };
      };

      # -- HM
    })
  ];
}

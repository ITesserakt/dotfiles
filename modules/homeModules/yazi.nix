{
  flake.homeModules.yazi =
    { pkgs, ... }:
    {
      programs.yazi = {
        enable = true;
        shellWrapperName = "y";
        settings.manager = {
          show_hidden = true;
        };
        settings.plugins = {
          prepend_previewers = [
            {
              mime = "application/*zip";
              run = "ouch";
            }
            {
              mime = "application/{x-tar,x-bzip2,x-7z-compressed,x-rar,x-xz,xz}";
              run = "ouch";
            }
            {
              url = "*.duckdb";
              run = "duckdb";
            }
          ];
          prepend_preloaders = [
            {
              url = "*.duckdb";
              run = "duckdb";
            }
          ];
        };
        initLua = ''
          require("duckdb"):setup()  
        '';
        keymap.mgr.prepend_keymap = [
          {
            on = [ "C" ];
            run = "plugin ouch";
            desc = "Compress with ouch";
          }
          {
            on = [
              "g"
              "o"
            ];
            run = "plugin duckdb -open";
            desc = "Open with duckdb";
          }
          {
            on = [
              "g"
              "u"
            ];
            run = "plugin duckdb -ui";
            desc = "Open with duckdb ui";
          }
        ];
        plugins = {
          ouch = pkgs.yaziPlugins.ouch;
          duckdb = pkgs.yaziPlugins.duckdb;
        };
        vfs.services = {
          redmi = {
            type = "sftp";
            host = "100.66.89.100";
            user = "tesserakt";
            port = 22;
          };
          archlinux = {
            type = "sftp";
            host = "100.121.107.19";
            user = "local";
            port = 22;
          };
          urmom = {
            type = "sftp";
            host = "100.84.11.95";
            user = "root";
            port = 22;
          };
        };
      };
    };
}

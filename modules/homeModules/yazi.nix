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
          ];
        };
        keymap.mgr.prepend_keymap = [
          {
            on = [ "C" ];
            run = "plugin ouch";
            desc = "Compress with ouch";
          }
        ];
        plugins = {
          ouch = pkgs.yaziPlugins.ouch;
        };
      };
    };
}

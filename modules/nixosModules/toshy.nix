{ inputs, ... }:
{
  flake.nixosModules.toshy = {
    imports = [
      inputs.toshy.nixosModules.default
    ];

    services.toshy.enable = true;
    nixpkgs.overlays = [ inputs.toshy.overlays.default ];
  };

  flake.nixosModules.toshy-emulation =
    { lib, ... }:
    {
      hardware.uinput.enable = true;

      services.udev.extraRules = ''
        KERNEL=="uinput", GROUP="input", MODE="0660", TAG+="uaccess"
      '';

      services.keyd =
        let
          mkBinds = prefix: binds: lib.genAttrs binds (name: "${prefix}-${name}");
        in
        {
          enable = true;
          keyboards.default = {
            extraConfig = lib.generators.toINI { } {
              main = {
                meta = "layer(meta_mac)";
                leftalt = "leftalt";
                fn = "overload(fn_key, A-f12)";
                sleep = "A-f11";
              };

              "meta_mac:M" = {
                c = "C-insert";
                v = "S-insert";
                x = "S-delete";

                tab = "swapm(app_switch_state, M-tab)";
                "`" = "A-f6";
                backspace = "delete";
                space = "M-space";
              }
              // mkBinds "C" [
                "d"
                "w"
                "a"
                "z"
              ];

              "app_switch_state:M" = {
                tab = "M-tab";
                right = "M-tab";
                "`" = "M-S-tab";
                left = "M-S-tab";
              };

              "altgr:G" = {
                left = "home";
                right = "end";
                backspace = "C-backspace";
              };

              fn_key = {
                esc = "toggle(fn_layer)";
              };

              fn_layer = {
                brightnessdown = "f1";
                brightnessup = "f2";
                scale = "f3";
                search = "f4";
                micmute = "f5";
                sleep = "f6";
                previoussong = "f7";
                playpause = "f8";
                nextsong = "f9";
                mute = "f10";
                volumedown = "f11";
                volumeup = "f12";
              };
            };
          };
        };
    };
}

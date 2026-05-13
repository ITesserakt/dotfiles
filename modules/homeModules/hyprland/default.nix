{ inputs, ... }:
{
  flake.homeModules.hyprland =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      hyprland-pkgs = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      home.packages = with pkgs; [
        wl-clipboard
        (hyprshot.override {
          hyprland = hyprland-pkgs.hyprland;
        })
      ];
      home.sessionVariables = {
        HYPRSHOT_DIR = "${config.home.homeDirectory}/Pictures/Screenshots";
      };
      home.file."${config.xdg.configHome}/hypr/.luarc.json".text = ''
        {
          "workspace": {
            "library": [
              "${hyprland-pkgs.hyprland}/share/hypr/stubs"
            ]
          },
          "diagnostics": {
            "globals": ["hl"]
          }
        }
      '';
      home.file."${config.xdg.configHome}/hypr/hyprland.lua".source = ./config/hyprland.lua;
      home.file."${config.xdg.configHome}/hypr/generated.lua".text = import ./config/_generated.nix {
        inherit pkgs lib;
      };

      xdg = {
        enable = lib.mkForce true;
        portal = {
          enable = lib.mkForce true;
          configPackages = [
            hyprland-pkgs.xdg-desktop-portal-hyprland
          ];
          extraPortals = [
            pkgs.xdg-desktop-portal-gtk
          ];
        };
      };

      services.hyprpolkitagent.enable = true;

      wayland.windowManager.hyprland = {
        enable = true;
        package = hyprland-pkgs.hyprland;
        portalPackage = hyprland-pkgs.xdg-desktop-portal-hyprland;
        xwayland.enable = true;
        systemd.enable = true;
        plugins = [ ];
      };
    };
}

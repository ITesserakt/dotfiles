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
        wlsunset
        brightnessctl
        (hyprshot.override {
          hyprland = hyprland-pkgs.hyprland;
        })
      ];
      home.sessionVariables = {
        HYPRSHOT_DIR = "${config.home.homeDirectory}/Pictures/Screenshots";
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

        settings.source = [
          "${config.xdg.configHome}/hypr/dynamic.conf"
        ];

        settings.bind = [
          "SUPER, 3, exec, ${lib.getExe pkgs.kitty} -e ${lib.getExe pkgs.btop}"
          "SUPER, 4, exec, ${lib.getExe pkgs.kitty}"
        ];

        plugins = [ ];
      };
    };
}

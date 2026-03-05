{
  flake.homeModules.hyprpanel =
    { pkgs, lib, ... }:
    {
      programs.hyprpanel = {
        enable = true;
        settings = (builtins.fromJSON (builtins.readFile "${pkgs.hyprpanel}/share/themes/nord.json")) // {
          scalingPriority = "hyprland";
          terminal = lib.getExe pkgs.kitty;
          tear = true;

          bar.layouts = {
            "*" = {
              left = [
                "dashboard"
                "workspaces"
                "windowtitle"
              ];
              middle = [
                "clock"
              ];
              right = [
                "netstat"
                "systray"
                "kbinput"
                "notifications"
              ];
            };
            "0" = {
              extends = "*";
              middle = [
                "clock"
                "media"
              ];
              right = [
                "systray"
                "volume"
                "battery"
                "network"
                "bluetooth"
                "kbinput"
                "cputemp"
                "hypridle"
                "notifications"
                "power"
              ];
            };
          };
          bar = {
            clock.format = "%a %b %d %H:%M";
            clock.showIcon = false;

            launcher.autoDetectIcon = true;
          };

          menus = {
            dashboard.shortcuts.enabled = false;
            dashboard.directories.enabled = false;
          };

          theme.font = {
            font = "Roboto Medium";
            size = "0.9rem";
          };
          theme.bar = {
            opacity = 75;
            menus.opacity = 75;
            border_radius = "1em";
            margin_top = "0.6em";
            margin_sides = "5em";
          };

          theme.bar.buttons.modules.cpuTemp = {
            background = "#3b4252";
            text = "#8fbcbb";
            border = "#8fbcbb";
            icon = "#8fbcbb";
            icon_background = "#3b4252";
          };
        };
      };
    };
}

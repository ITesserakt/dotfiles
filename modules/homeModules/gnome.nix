{
  flake.homeModules.gnome =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        papers
        mission-center
        clapper
        loupe
        nautilus
        file-roller
      ];
    };

  flake.homeModules.gnome-extensions =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        gnome-shell-extensions
        gnomeExtensions.appindicator
        gnomeExtensions.blur-my-shell
        gnomeExtensions.clipboard-indicator
        gnomeExtensions.pip-on-top
        gnomeExtensions.hide-hide-top-bar
        gnomeExtensions.caffeine
        gnomeExtensions.rounded-window-corners-reborn
        gnomeExtensions.touchpad-gesture-customization
      ];
    };
}

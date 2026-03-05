{
  flake.homeModules.hypridle.services.hypridle = {
    enable = true;

    settings.listener = [
      {
        timeout = 300;
        on-timeout = ''loginctl lock-session'';
      }
      {
        timeout = 330;
        on-timeout = ''hyprctl dispatch dpms off'';
        on-resume = ''hyprctl dispatch dpms on'';
      }
    ];
  };
}

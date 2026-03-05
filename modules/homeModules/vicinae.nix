{
  flake.homeModules.vicinae.programs.vicinae = {
    enable = true;
    systemd.enable = true;
    settings = {
      pop_to_root_on_close = true;
      launcher_window.blur.enabled = true;
    };
  };
}

{
  flake.homeModules.kitty.programs.kitty = {
    enable = true;
    enableGitIntegration = true;
    settings = {
      copy_on_select = true;
      enable_audio_bell = false;
      close_on_child_detach = true;
      confirm_on_window_close = false;
    };
  };
}

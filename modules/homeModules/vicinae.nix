{ inputs, ... }: {
  flake.homeModules.vicinae = {
    imports = [
      inputs.vicinae.homeManagerModules.default
    ];
    
    services.vicinae = {
      enable = true;
      systemd.enable = true;
      settings = {
        pop_to_root_on_close = true;
        launcher_window.blur.enabled = true;
      };
    };
  };
}

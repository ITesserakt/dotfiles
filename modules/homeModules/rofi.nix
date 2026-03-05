{
  flake.homeModules.rofi = { pkgs, lib, ... }: {
    programs.rofi = {
      enable = true;
      pass.enable = true;
      terminal = lib.getExe pkgs.alacritty;
    };
  };
}

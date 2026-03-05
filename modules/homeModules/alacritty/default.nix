{
  flake.homeModules.alacritty.programs.alacritty = {
    enable = true;
    settings = {
      general."import" = [ ./alacritty.toml ];
      font.size = 12;
      window.padding = {
        x = 4;
        y = 4;
      };
      window.dynamic_title = true;
      cursor.style = {
        shape = "Beam";
        blinking = "On";
      };
    };
  };
}

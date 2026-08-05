{
  flake.modules.darwin.yabai = {
    services.yabai = {
      enable = true;
      enableScriptingAddition = true;
    };
  };
}

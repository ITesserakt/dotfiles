{
  flake.homeModules.wezterm =
    { pkgs, ... }:
    {
      programs.wezterm = {
        enable = true;
        extraConfig = ''
          return {
            font = wezterm.font {
              family = 'JetBrains Mono',
              harfbuzz_features = { 'calt=0', 'clig=0', 'liga=1' }
            },
            hide_tab_bar_if_only_one_tab = true,
            window_background_opacity = 0.95,
            default_prog = { '${pkgs.zellij}/bin/zellij', 'options', '--default-shell', 'nu' },
            window_padding = {
              left = 0,
              right = 0,
              top = 0,
              bottom = 0
            },
            window_decorations = 'TITLE | RESIZE',
            window_close_confirmation = 'NeverPrompt',
            detect_password_input = true,
            keys = {{
              key = ')',
              mods = 'CTRL',
              action = wezterm.action.CloseCurrentPane { confirm = false },
            }}
          }
        '';
      };
    };
}

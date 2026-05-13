{ pkgs, lib }:
# lua
''
  hl.bind("SUPER + 3", hl.dsp.exec_cmd("${lib.getExe pkgs.kitty} -e ${lib.getExe pkgs.btop}"))
  hl.bind("SUPER + 4", hl.dsp.exec_cmd("${lib.getExe pkgs.kitty}"))

  hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
  hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
  hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("${lib.getExe pkgs.brightnessctl} s +5%"),                        { locked = true, repeating = true })
  hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("${lib.getExe pkgs.brightnessctl} s 5%-"),                      { locked = true, repeating = true })

  hl.bind("XF86AudioMute", hl.dsp.exec_cmd("${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),      { locked = true })
  hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
  hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("${lib.getExe pkgs.playerctl} play-pause"),                            { locked = true })
  hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("${lib.getExe pkgs.playerctl} previous"),                              { locked = true })
  hl.bind("XF86AudioNext", hl.dsp.exec_cmd("${lib.getExe pkgs.playerctl} next"),                                  { locked = true })
''

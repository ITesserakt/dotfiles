require("dynamic")
require("generated")

-- FIXME: stylix color settings are not applied in lua configs

hl.config({
  general = {
    col = {
      active_border = "rgb(81a1c1)",
      inactive_border = "rgb(4c566a)"
    },
  },
  misc = {
    background_color = "rgb(2e3440)"
  },
  group = {
    groupbar = {
      col = {
        active = "rgb(81a1c1)",
        inactive = "rgb(4c566a)",
      },
      text_color = "rgb(e5e9f0)"
    },
    col = {
      border_active = "rgb(81a1c1)",
      border_inactive = "rgb(4c566a)",
      border_locked_active = "rgb(88c0d0)"
    }
  }
})


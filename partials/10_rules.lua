-- {{{ Rules
--
-- to figure out what to use here, run 
--
--      % xprop WM_CLASS
--
--
--  then click on the client
--
--
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = {
                        -- eliminate gaps between applications
                        size_hints_honor = false,
                        --
                        border_width = beautiful.border_width,
                        border_color = beautiful.border_normal,
                        focus = awful.client.focus.filter,
                        keys = clientkeys,
                        buttons = clientbuttons } },
    -- { rule = { class = "xboard" },      properties = { floating = true } },
    { rule = { class = "Chromium" },                properties = { floating = false } },
    { rule = { class = "MPlayer" },                 properties = { floating = false } },
    { rule = { class = "free-jin-JinApplication" }, properties = { floating = false } },
    { rule = { class = "gimp" },                    properties = { floating = true } },
    { rule = { class = "google-chrome"},            properties = { floating = false } },
    { rule = { class = "Google-chrome"},            properties = { floating = false } },
    { rule = { class = "libreoffice-calc" },        properties = { floating = false } },
    { rule = { class = "libreoffice-writer" },      properties = { floating = false } },
    { rule = { class = "mplayer" },                 properties = { floating = false } },
    { rule = { class = "pinentry" },                properties = { floating = true } },
    { rule = { class = "XMathematica" },            properties = { floating = false } },
    { rule = { class = "Nautilus" },                properties = { floating = false } },
    { rule = { class = "mono" },                    properties = { floating = false} },
    { rule = { class = "devede" },                  properties = { floating = true} },
    { rule = { class = "Devede" },                  properties = { floating = true} },
    { rule = { class = "XMathematica" },            properties = { floating = false} }
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
}
-- }}}

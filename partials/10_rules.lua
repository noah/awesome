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
                        screen = awful.screen.focused,
                        keys = clientkeys,
                        buttons = clientbuttons } },
    -- { rule = { class = "xboard" },      properties = { floating = true } },
    { rule = { class = "Thunderbird", instance="Mail" },
            properties = { 
                    tag = tags[1][7]
            } },
    { rule = { class = "Chromium" },                
            properties = { 
                    floating = false,
                    tag = tags[1][2]
            } },
    { rule = { class = "google-chrome"},            properties = { 
            floating = false,
            tag = tags[1][2]
    } },
    { rule = { class = "Google-chrome"},            properties = { 
            floating = false,
            tag = tags[1][2]
    } },
    { rule = { class = "xfreerdp", instance="xfreerdp" },                
            properties = { 
                    floating = false
                    -- tag = tags[1][2]
            } },
    { rule = { class = "Firefox", instance="Navigator" },                
            properties = { 
                    floating = false,
                    ontop=false,
                    sticky=false,
                    maximized=false
                    -- tag = tags[1][2]
            } },

    { rule = { class = "Evince", instance="evince" },                
            properties = { 
                    floating = false,
                    ontop=false,
                    sticky=false,
                    maximized=false
                    -- tag = tags[1][2]
            } },
    { rule = { class = "libreoffice-draw", instance="libreoffice" },                
            properties = { 
                    floating = false,
                    ontop=false,
                    sticky=false,
                    maximized=false
                    -- tag = tags[1][2]
            } },
    { rule = { 
            class = "Pidgin", instance="Pidgin" },
            properties = {
                    floating = false
            } },
    { rule = { class = "free-jin-JinApplication", instance = "sun-awt-X11-XDialogPeer" }, 
            properties = { 
                    floating = true,
                    tag = tags[1][5]
            } },
    { rule = { class = "free-jin-JinApplication", instance = "sun-awt-X11-XFramePeer" }, 
            properties = { 
                    floating = false,
                    tag = tags[1][5]
            } },
    { rule = { class = "Plugin-container", instance = "plugin-container" },                    properties = { floating = true } },
    { rule = { class = "gimp" },                    properties = { floating = true } },
    --    { rule = { instance = "libreoffice" },          properties = { floating = false } },
    --    { rule = { class = "libreoffice-writer" },      properties = { floating = false } },
    { rule = { class = "mplayer" },                 properties = { floating = false } },
    { rule = { class = "MPlayer" },                 properties = { floating = false } },
    { rule = { instance="gtkpod" },                 properties = { floating = false } },
    { rule = { 
      class = "Nautilus",
      instance="nautilus" },
      properties = { 
        floating = false,
        sticky = false
      } 
    },
    { rule = { 
      class = "rdesktop",
      instance="rdesktop" },
      properties = { 
        floating = false,
        sticky = false
      } 
    },
    { rule = { class = "pinentry" },                properties = { floating = true } },
    { rule = { class = "XMathematica" },            properties = { floating = false } },
    { rule = { class = "mono" },                    properties = { floating = false} },
    { rule = { class = "devede" },                  properties = { floating = true} },
    { rule = { class = "Devede" },                  properties = { floating = true} },
    { rule = { class = "XMathematica" },            properties = { floating = false} }
}
-- }}}

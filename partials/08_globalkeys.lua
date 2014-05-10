

globalkeys = awful.util.table.join(

    keydoc.group("Screen navigation / movement"),
      -- navigation
        awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end, "focus right"),
        awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end, "focus left"),

    keydoc.group("Tag navigation"),
      -- navigation
        awful.key({ modkey, "Control" }, "h",   awful.tag.viewprev, "go to left tag"),
        awful.key({ modkey, "Control" }, "l",  awful.tag.viewnext, "go to right tag"),
        awful.key({ modkey,           }, "Escape", awful.tag.history.restore, "toggle between current and last-visited tag"),

    keydoc.group("Client navigation / movement"),
      -- navigation
        awful.key({ modkey,           }, "j", function ()
                awful.client.focus.byidx( 1)
                if client.focus then client.focus:raise() end
        end, "go to tag below"),
        awful.key({ modkey,           }, "k", function ()
                awful.client.focus.byidx(-1)
                if client.focus then client.focus:raise() end
        end, "go to tag above"),
        awful.key({ modkey,           }, "u", awful.client.urgent.jumpto, "focus urgent client"),
        awful.key({ modkey,           }, "Tab",
            function ()
                -- awful.client.focus.history.previous()
                awful.client.focus.byidx(-1)
                if client.focus then
                    client.focus:raise()
                end
            end, "alt-tab (client switcher"),
        awful.key({ modkey, "Shift"   }, "Tab",
            function ()
                -- awful.client.focus.history.previous()
                awful.client.focus.byidx(1)
                if client.focus then
                  client.focus:raise()
                end
            end, "alt-tab (client switcher, in reverse)"),

      -- movement
        awful.key({ modkey, "Shift"   }, "y", function () awful.client.cycle(true)    end, "cycle clients (clockwise)"),
        awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end, "move client down"),
        awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end, "move client up"),
        awful.key({ modkey, }, "n", function (_) 
                -- show clients menu, unminimize client on keypress
                --
                -- TODO minimize sucks, probably better implemented as a history
                -- stack, like client.focus.history
                --
                -- construct a table of the clients on the current tag
                -- tht are 
                local tag = awful.tag.selected()
                local mcs = {} -- minimized clients
                for j, c in pairs(tag:clients()) do
                        if c.minimized then
                                table.insert(mcs, {c.name, 
                                function()
                                        awful.tag.viewonly(c:tags()[1])
                                        client.focus = c
                                end,
                                c.icon })
                        end
                end
                if #mcs == 1 then
                        mcs[1][2]()   -- raise if only one client minimized
                else
                        awful.menu(mcs):show()  -- show the menu
                end
        end, "show maximize menu" ),
        awful.key({ modkey, "Control" }, "n", awful.client.restore, "restore client"),
        awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end, "resize client if view allows-left"),
        awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end, "resize client if view allows-right"),
        --awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end, "resize client if view allows-left"),
        --awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end, "resize client if view allows-left"),
        --awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end, "resize client if view allows-left"),
        --awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end, "resize client if view allows-left"),


    keydoc.group("Layouts"),
        awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end, "cycle layout"),
        awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end, "cycle layout (reverse)"),

    keydoc.group("Misc"),
      awful.key({ modkey, }, "w", function () mymainmenu:show() end, "show main menu"),
      awful.key({ modkey, }, "p", function() menubar.show() end, "show program prompt"),
      awful.key({ }, "F1", keydoc.display, "show this help"),
      awful.key({ modkey, "Control" }, "r", awesome.restart, "restart awesome"),
      awful.key({ modkey, "Shift"   }, "q", awesome.quit, "quit awesome"),

    -- Standard program
    keydoc.group("Program keys"),
      awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end, "open terminal (no daemon)"),
      awful.key({ modkey, "Shift"   }, "Return", function() awful.util.spawn(terminald, false) end, "open terminal (daemon)"),
      awful.key({ modkey,           }, "e", function() awful.util.spawn("nautilus", false) end, "open file manager GUI"),

      -- keybindings
      awful.key({         }, "Scroll_Lock",   function () awful.util.spawn("xscreensaver-command -lock",false)    end),
      awful.key({         }, "Print",         function () awful.util.spawn("gnome-screenshot -a -i", false)end),
      awful.key({ "Shift" }, "Print",         function () awful.util.spawn("gnome-screenshot -w", false)end),

    -- winamp-stylez
    -- volume
    --  Up:      Num Pad up
    --  Down:    Num Pad down
    -- playlist
    --  Next:    Page Down
    --  Prior:   Page Up
    --  Home:    Home key
    keydoc.group("Media keys"),
      awful.key({ modkey, "Control", }, 
                  "Up",     function () awful.util.spawn("amixer -c 0 sset Master 1+%", false) end, "Increase volume 1%"),
      awful.key({ modkey, "Control", }, 
                  "Down",   function () awful.util.spawn("amixer -c 0 sset Master 1-%", false) end, "Decrease volume 1%"),
      awful.key({ modkey, "Control", }, 
                  "Next",   function () awful.util.spawn(script_dir .. "/playback.sh next",false) end, "Skip to next track"),
      awful.key({ modkey, "Control", }, 
                  "Prior",  function () awful.util.spawn(script_dir .. "/playback.sh prev",false) end, "Skip to prev track"),
      awful.key({ modkey, "Control", }, 
                  "Home",   function () awful.util.spawn(script_dir .. "/playback.sh pause",false)    end, "Pause toggle playback"),
      awful.key({ modkey, "Control", }, 
                  "Right",  function () awful.util.spawn(script_dir .. "/playback.sh ffwd",false)    end, "Fast foward playing track by 5 seconds"),
      awful.key({ modkey, "Control", }, 
                  "Left",  function () awful.util.spawn(script_dir .. "/playback.sh rew",false)    end, "Rewind playing track by 5 seconds")

    -- Tags TODO
    -- awful.key({ modkey, }, "d", function () awful.tag.delete() end),    -- delete tag
    -- awful.key({ modkey,           }, "r",                               -- rename tag
    -- function ()
    --   awful.prompt.run({ prompt = "New tag name: ", text=awful.tag.selected(mouse.screen).name},
    --   mypromptbox[mouse.screen].widget,
    --   function(new_name)
    --     if not new_name or #new_name == 0 then
    --       return
    --     else
    --       local screen = mouse.screen
    --       local tag = awful.tag.selected(screen)
    --       if tag then
    --         tag.name = new_name
    --       end
    --     end
    --   end)
    -- end)
    -- awful.key({ modkey,           }, "a", -- add tag
    -- function ()
    --   awful.prompt.run({ prompt = "New tag name: " },
    --   mypromptbox[mouse.screen].widget,
    --   function(new_name)
    --     if not new_name or #new_name == 0 then
    --       return
    --     else
    --       props = {selected = true}
    --       if tyrannical.tags_by_name[new_name] then
    --         props = tyrannical.tags_by_name[new_name]
    --       end
    --       t = awful.tag.add(new_name, props)
    --       awful.tag.viewonly(t)
    --     end
    --   end
    --   )
    -- end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
-- for i = 1, keynumber do
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                           awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

root.keys(globalkeys)

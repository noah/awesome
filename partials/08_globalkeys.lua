-- vi-like menu navigation bindings
--
awful.menu.menu_keys.up     = { "k" }
awful.menu.menu_keys.down   = { "j" }
awful.menu.menu_keys.close  = { "q", "Escape" }

local keydoc = require("keydoc")

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
                -- awful.client.focus.byidx( 1)
                awful.client.focus.bydirection("down")
                if client.focus then client.focus:raise() end
        end, "go to tag below"),
        awful.key({ modkey,           }, "k", function ()
                -- awful.client.focus.byidx(-1)
                awful.client.focus.bydirection("up")
                if client.focus then client.focus:raise() end
        end, "go to tag up"),
        awful.key({ modkey,           }, "l", function ()
                -- awful.client.focus.byidx(-1)
                awful.client.focus.bydirection("right")
                if client.focus then client.focus:raise() end
        end, "go to tag right"),
        awful.key({ modkey,           }, "h", function ()
                -- awful.client.focus.byidx(-1)
                awful.client.focus.bydirection("left")
                if client.focus then client.focus:raise() end
        end, "go to tag left"),
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
                        awful.menu(mcs):show()
                end
        end, "show maximize menu" ),
        awful.key({ modkey, "Control" }, "n", awful.client.restore, "restore client"),
        awful.key({ modkey,           }, "Right",     function () awful.tag.incmwfact( 0.05)    end, "resize client if view allows-left"),
        awful.key({ modkey,           }, "Left",     function () awful.tag.incmwfact(-0.05)    end, "resize client if view allows-right"),
        awful.key({ modkey, "Shift"   }, "Left",     function () awful.tag.incnmaster( 1)      end, "resize client if view allows-left"),
        awful.key({ modkey, "Shift"   }, "Right",     function () awful.tag.incnmaster(-1)      end, "resize client if view allows-left"),
        awful.key({ modkey, "Control" }, "Left",     function () awful.tag.incncol( 1)         end, "resize client if view allows-left"),
        awful.key({ modkey, "Control" }, "Right",     function () awful.tag.incncol(-2)         end, "resize client if view allows-left"),


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
      awful.key({ "Control"}, "q", function () return false end, "prevent firefox from quitting"),
      awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end, "open terminal (no daemon)"),
      awful.key({ modkey, "Shift"   }, "Return", function() awful.util.spawn(terminald, false) end, "open terminal (daemon)"),
      awful.key({ modkey,           }, "e", function() awful.util.spawn("nautilus", false) end, "open file manager GUI"),

      -- keybindings
      awful.key({         }, "Scroll_Lock",   function () awful.util.spawn("killall ssh; xscreensaver-command -lock",false)    end),

      -- screen capture
      awful.key({         }, "Print",         function () 
                                                       awful.util.spawn_with_shell("maim -s | xclip -selection clipboard -t image/png", false)
                                                       
                                                end),

      awful.key({ modkey }, "Print",         function () 
                                                       local _fn="/home/noah/screen_capture_" .. os.date("%Y-%m-%d_%H:%M:%S") .. ".png"
                                                       awful.util.spawn("maim -s " .. _fn, false)
                                                       awful.util.spawn("exiftool -all= " .. _fn, false)
                                                end),


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
                  "Up",     function () awful.util.spawn(script_dir .. "/volume.sh +", false) end, "Increase volume 1%"),
      awful.key({ modkey, "Control", }, 
                  "Down",   function () awful.util.spawn(script_dir .. "/volume.sh -", false) end, "Decrease volume 2%"),
      awful.key({ modkey, "Control", }, 
                  "m",   function () awful.util.spawn(script_dir .. "/volume.sh m", false) end, "Toggle mute"),
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

-- -- Bind all key numbers to tags.
-- -- Be careful: we use keycodes to make it works on any keyboard layout.
-- -- This should map on the top row of your keyboard, usually 1 to 9.
-- -- for i = 1, keynumber do
-- for i = 1, 9 do
--     globalkeys = awful.util.table.join(globalkeys,
--         awful.key({ modkey }, "#" .. i + 9,
--                   function ()
--                         local screen = mouse.screen
--                         if tags[screen][i] then
--                            awful.tag.viewonly(tags[screen][i])
--                         end
--                   end),
--         awful.key({ modkey, "Control" }, "#" .. i + 9,
--                   function ()
--                       local screen = mouse.screen
--                       if tags[screen][i] then
--                           awful.tag.viewtoggle(tags[screen][i])
--                       end
--                   end),
--         awful.key({ modkey, "Shift" }, "#" .. i + 9,
--                   function ()
--                       if client.focus and tags[client.focus.screen][i] then
--                           awful.client.movetotag(tags[client.focus.screen][i])
--                       end
--                   end),
--         awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
--                   function ()
--                       if client.focus and tags[client.focus.screen][i] then
--                           awful.client.toggletag(tags[client.focus.screen][i])
--                       end
--                   end))
-- end
--


-- tag functions
local function show_tag(i)
        local screen = mouse.screen.index
        if tags[screen][i] then
           awful.tag.viewonly(tags[screen][i])
        end
end

local function show_both(i)
      local screen = mouse.screen.index
      if tags[screen][i] then
          awful.tag.viewtoggle(tags[screen][i])
      end
end

local function move_to_tag(i)
      if client.focus and tags[client.focus.screen.index][i] then
        awful.client.movetotag(tags[client.focus.screen.index][i])
      end
end

local function huh(i)
      -- what the hell does this do?
      if client.focus and tags[client.focus.screen.index][i] then
          awful.client.toggletag(tags[client.focus.screen.index][i])
      end
end

-- Bind top-row number keys and number pad keys to tags.
--

local function to_awesome_keycode( i )
    -- use xev(1) to find keycodes.  the format here is "#keycode".  the '#'
    -- prefix is an awesome-specific convention. 
    return '#' .. i
end

-- keypad keys 1-9
local numberpad_keycodes = { 87, 88, 89, 83, 84, 85, 79, 80, 81 }

local function set_keys(t, keycode)
    keycode         = to_awesome_keycode( keycode )
    globalkeys      = awful.util.table.join(globalkeys,
                        awful.key({ modkey }, keycode, function() show_tag(t) end),
                        awful.key({ modkey, "Control" }, keycode, function() show_both(t) end),
                        awful.key({ modkey, "Shift" }, keycode, function() move_to_tag(t) end),
                        awful.key({ modkey, "Control", "Shift" }, keycode, function() huh(t) end)
    )
end

-- keys 1-12 (1-9, 0, -, =) and number pad 1-9
for i=1, TAGS_MAX do
    set_keys(i, i+9)
    if numberpad_keycodes[i] ~= nil then
        set_keys(i, numberpad_keycodes[i])
    end
end

-- Number pad keys 10-12 (0, *, -)
set_keys(10, 90) -- keypad key '0', tag 0
set_keys(11, 63) -- keypad key '*', tag -
set_keys(12, 82) -- keypad key '-', tag =

root.keys(globalkeys)

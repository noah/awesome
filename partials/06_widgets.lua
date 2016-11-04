local wibox     = require("wibox")
local vicious   = require("vicious")
vicious.contrib = require("vicious.contrib")

gnarly = require("gnarly")
local log = gnarly.util.log

-- {{{ Wibox
-- Create widgets
-- mytextclock = awful.widget.textclock()

-- Create a wibox for each screen and add it
mywibox_top = {}
mywibox_bot = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag)
                    -- awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    -- awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

-- widgets
delimiter   = wibox.widget.textbox()
delimiter:set_text(" ")

datebox     = wibox.widget.textbox()
membox      = wibox.widget.textbox()
uptimebox   = wibox.widget.textbox()
volbox      = wibox.widget.textbox()
pacbox      = wibox.widget.textbox()
wifibox     = wibox.widget.textbox()
musicbox    = wibox.widget.textbox()
mdirbox     = wibox.widget.textbox()
batterybox  = wibox.widget.textbox()

cpugraph    = awful.widget.graph()
cpugraph:set_width(100)
cpugraph:set_color(beautiful.bg_focus)
-- cpugraph:set_gradient_colors({ "#FF5656", "#88A175", "#AECF96" })


for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox_top[s] = awful.wibox({ position = "top", screen = s })
    mywibox_bot[s] = awful.wibox({ position = "bottom", screen = s })

    -- Widgets that are aligned to the left
    local top_left_layout = wibox.layout.fixed.horizontal()
    top_left_layout:add(mylauncher)
    top_left_layout:add(mytaglist[s])
    top_left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local top_right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then 
      top_right_layout:add(wibox.widget.systray()) 
    end

    top_right_layout:add(delimiter)
    top_right_layout:add(uptimebox)
    top_right_layout:add(delimiter)
    top_right_layout:add(cpugraph)
    top_right_layout:add(delimiter)
    top_right_layout:add(membox)
    top_right_layout:add(delimiter)
    top_right_layout:add(wifibox)
    top_right_layout:add(delimiter)
    top_right_layout:add(datebox)
    top_right_layout:add(delimiter)
    top_right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local top_layout = wibox.layout.align.horizontal()
    top_layout:set_left(top_left_layout)
    top_layout:set_middle(mytasklist[s])
    top_layout:set_right(top_right_layout)

    -- define bottom layout
    local bot_left_layout = wibox.layout.fixed.horizontal()
    bot_left_layout:add(delimiter)
    bot_left_layout:add(mdirbox)

    -- local bot_middle_layout = wibox.layout.fixed.horizontal()
    local bot_right_layout = wibox.layout.fixed.horizontal()
    bot_right_layout:add(volbox)
    bot_right_layout:add(delimiter)
    bot_right_layout:add(musicbox)
    bot_right_layout:add(delimiter)
    bot_right_layout:add(wifibox)
    bot_right_layout:add(delimiter)
    bot_right_layout:add(batterybox)
    bot_right_layout:add(delimiter)

    local top_layout = wibox.layout.align.horizontal()
    top_layout:set_left(top_left_layout)
    top_layout:set_middle(mytasklist[s])
    top_layout:set_right(top_right_layout)

    local bot_layout = wibox.layout.align.horizontal()
    bot_layout:set_left(bot_left_layout)
    -- bot_layout:set_middle(mytasklist[s])
    bot_layout:set_right(bot_right_layout)

    mywibox_top[s]:set_widget(top_layout)
    mywibox_bot[s]:set_widget(bot_layout)
end
-- }}}

gnarly.cmus     = require("gnarly.cmus")
gnarly.mdir     = require("gnarly.mdir")
-- gnarly.yaourt   = require("gnarly.yaourt")
-- gnarly.yaourt   = require("gnarly.yaourt")
gnarly.battery  = require("gnarly.battery")

-- vicious widgets
vicious.register(datebox, vicious.widgets.date, "%A %Y-%m-%d %H:%M %Z", 60)
-- 
vicious.register(uptimebox, vicious.widgets.uptime,
    function (widget, args)
        return printf("up%2dd %02dh %02dm", args[1], args[2], args[3])
    end, 71)
-- 
vicious.register(membox, vicious.widgets.mem,    
    function(widget, args)
        return printf("mem %d%% (%d/%d GB)", args[1], math.floor(args[2]/1024.0), math.floor(args[3]/1024.0))
    end, 13)
-- 

local active_sink = tonumber( 
        awful.util.pread("pacmd list-sinks | grep '* index' -A 20|grep -Po '(?<=\tname: <).*(?=>)'") )

vicious.register(wifibox,   vicious.widgets.wifi,   "${ssid} ${link}% ${rate} MB/s", 16, "wlp3s0")
vicious.register(cpugraph, vicious.widgets.cpu, "$1", 3)

vicious.register(volbox, vicious.contrib.pulse, "vol $1%", 2, active_sink)

volbox:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("pavucontrol") end),
    awful.button({ }, 5, function () vicious.contrib.pulse.add(5, active_sink) end),
    awful.button({ }, 4, function () vicious.contrib.pulse.add(-5, active_sink) end)
))
-- 
vicious.register(musicbox, gnarly.cmus, 
    function(widget, T)
      if T["{error}"] then return "error: " .. T["{status}"] end
      if T["{status}"] == "stopped" or T["{status}"] == "not running" then 
        return printf("♫ %s", T["{status_symbol}"]) 
      end

      return printf("♫  %s %s %s %s", 
                              T["{status_symbol}"],
                              T["{song}"],
                              T["{remains_pct}"],
                              T["{CRS}"]
                          )
    end, 2)

vicious.register(batterybox, gnarly.battery,
    function(widget, T)
        return printf("%s: %u%%", T['{status}'], T['{charge}'])
    end, 11)

-- 
vicious.register(mdirbox, gnarly.mdir, 
    function(widget, mailboxes)
      _t    = {}
      count = 0
      for k, v in pairs(mailboxes) do
        table.insert(_t, "{" .. k .. " => " .. v .. "}")
        count = count + 1
      end
      if count > 0 then
        return join(_t, " ")
      else
        return "✓"
      end

    end, 1, "/home/noah*/mail/noah@*.com")
-- 
-- 
-- vicious.register(pacbox, gnarly.yaourt,
--   function(widget, n)
--     return n["pacman"] .. " (pacman) " .. n["aur"] .. " (aur)"
--   end, 643)
-- vicious.register(pacbox, gnarly.yaourt,
--   function(widget, n)
--     return n["pacman"] .. " (pacman) " .. n["aur"] .. " (aur)"
--   end, 643)

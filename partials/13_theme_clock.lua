-- a timer to set the awesome window manager theme colors based on the
-- time of day

local active = "light" -- default

--
local tm = timer({timeout=1800})
-- local tm = timer({timeout=3})
tm:connect_signal("timeout", function ()
        -- theme.font = 'Sans 10'
        -- local screen = mouse.screen
        -- local tag = awful.tag.getidx(awful.tag.selected())
        -- hack - switch to next tag and quickly back so theme will
        -- update
        -- TODO figure out one call for this
        -- awful.tag.viewnext()
        -- awful.tag.viewprev()
        --
        local function set_theme(t)
                    active = t
                    -- beautiful.init(awful.util.getdir("config") .. "themes/" .. active .. "/theme.lua")
                    -- awesome.restart()
        end

        local hour = tonumber(os.date("%H"))
        if (hour < 18 and hour > 7) then
                if active ~= "light" then
                        set_theme("light")
                end
        else
                if active ~= "dark" then
                        set_theme("dark")
                end
        end
        awful.tag.viewnext()
        awful.tag.viewprev()
end)
tm:start()

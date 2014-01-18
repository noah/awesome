local gears = require("gears")

-- N.B. colors defined in theme.lua are available as properties of
-- beautiful (e.g., beautiful.border_color)
beautiful.init(config_dir .. "/themes/theme.lua")
--                           ^ symlink
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
 

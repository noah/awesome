---------------------------
-- esq awesome theme --
---------------------------

theme = {}
theme.font          = "Monaco 10"


-- You can use your own command to set your wallpaper
-- theme.wallpaper     = "~/background"
--

--wallpaper_cmd = "feh --bg-fill ~/background"

theme.fg_normal     = "#000000"
theme.bg_normal     = "#ffffff"

theme.fg_focus      = "#ffffff"
theme.bg_focus      = "#332f30"

theme.fg_urgent     = "#ffffff"
theme.bg_urgent     = "#ff0000"

theme.fg_minimize   = "#cccccc"
theme.bg_minimize   = "#7f7f7f"

theme.border_width  = "0"
theme.border_normal = "#000000"
theme.border_focus  = "#535d6c"
theme.border_marked = "#91231c"


-- There are another variables sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- Example:
-- taglist_bg_focus = #ff0000

-- Display the taglist squares
theme.taglist_squares_sel = "~/.config/awesome/themes/default/taglist/squarefw.png"
theme.taglist_squares_unsel = "~/.config/awesome/themes/default/taglist/squarew.png"

theme.tasklist_floating_icon = "~/.config/awesome/themes/default/tasklist/floatingw.png"

-- Variables set for theming menu
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon     = "~/.config/awesome/themes/default/submenu.png"
theme.menu_height           = "16"
theme.menu_width            = "512"
theme.menu_border_width     = "0"
-- theme.menu_border_color     = "#FF69B4"
-- theme.menu_bg_normal        = "#000000"
-- theme.menu_fg_normal        = "#ffffff"
-- theme.menu_bg_focus         = "#ffffff"
-- theme.menu_fg_focus         = "#000000"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
-- bg_widget    = #cc0000

-- Define the image to load
theme.titlebar_close_button_normal = "~/.config/awesome/themes/default/titlebar/close_normal.png"
theme.titlebar_close_button_focus = "~/.config/awesome/themes/default/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = "~/.config/awesome/themes/default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive = "~/.config/awesome/themes/default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = "~/.config/awesome/themes/default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = "~/.config/awesome/themes/default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = "~/.config/awesome/themes/default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = "~/.config/awesome/themes/default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = "~/.config/awesome/themes/default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = "~/.config/awesome/themes/default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = "~/.config/awesome/themes/default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = "~/.config/awesome/themes/default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = "~/.config/awesome/themes/default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = "~/.config/awesome/themes/default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = "~/.config/awesome/themes/default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive = "~/.config/awesome/themes/default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = "~/.config/awesome/themes/default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active = "~/.config/awesome/themes/default/titlebar/maximized_focus_active.png"

-- You can use your own layout icons like this:
theme.layout_fairh = "~/.config/awesome/themes/default/layouts/fairh.png"
theme.layout_fairv = "~/.config/awesome/themes/default/layouts/fairv.png"
theme.layout_floating = "~/.config/awesome/themes/default/layouts/floating.png"
theme.layout_magnifier = "~/.config/awesome/themes/default/layouts/magnifier.png"
theme.layout_max = "~/.config/awesome/themes/default/layouts/max.png"
theme.layout_fullscreen = "~/.config/awesome/themes/default/layouts/fullscreen.png"
theme.layout_tilebottom = "~/.config/awesome/themes/default/layouts/tilebottom.png"
theme.layout_tileleft = "~/.config/awesome/themes/default/layouts/tileleft.png"
theme.layout_tile = "~/.config/awesome/themes/default/layouts/tile.png"
theme.layout_tiletop = "~/.config/awesome/themes/default/layouts/tiletop.png"

--theme.awesome_icon = "~/.config/awesome/themes/my/awesome-icon.png"



return theme
-- vim: filetype=lua

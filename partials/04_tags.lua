-- {{{ Tags
--

-- Only 12 keys will be used for tags (keyboard order).  Tags are
-- indexed in top-row natural keyboard order [1,2,3,...,0,'-',='].  This
-- indexing corresponds to the alt+-prefixed keybindings they receive
-- elsewhere and gives a pretty good reasonable total of 12 tags per
-- screen.  That extends the number of available tags beyond the awesome
-- default of 9 (1 ... 9).  Tags can have arbitrary names, one per line,
-- in TAGS_FILE.
--
TAGS_MAX    = 12
TAGS_FILE   = table.concat({config_dir, "tags.txt"}, "/")


-- get tag names from file
local tagslist = {}
for tag in io.lines( TAGS_FILE ) do
        table.insert(tagslist, tag)
end

-- sanity check
if #tagslist > TAGS_MAX then
        log("warn: " .. TAGS_MAX .. " tags max, " 
                .. math.abs( TAGS_MAX-#tagslist  ) 
                .. " will be ignored")
end

-- take first TAGS_MAX, ignore remainder
mytags = {}
for i=1, TAGS_MAX do
        mytags[i] = "  " .. tagslist[i] .. " "
end

-- create a tag table per screen
tags = {}
for s = 1, screen.count() do
    tags[s] = awful.tag(mytags, s, layouts[1]) 
end

-- }}}
--


-- Tag rules TODO
--
--
--
-- name_rules = {
--         { name = "vim", tag = "vim" }
-- }
-- 
-- local function tag_index_from_name(n) 
-- 
--         for i=1, #tags[1] do
--             if string.match(tags[1][i].name, n) then
--                     return i
--             end
--         end
--         return nil
-- end
-- 
-- function dispatch_tags(c)
--         -- dynamic tagging
--         --
--         -- get client name ("title" in xterm parlance; WM_NAME in xprop)
--         -- local client_name   = c.name 
-- 
--         -- -- get client class (WM_NAME in xprop)
--         -- local client_class  = c.name
-- 
--         -- for i=1, #name_rules do
--         --     local rule = name_rules[i]
--         --     if string.match(client_name, rule.name) then
--         --             -- name matched, move to tag
--         --             --
--         --             local t = awful.tag.gettags(c.screen)
--         --             local tag_exists = false
--         --             for j=1, #t do
--         --                     if t[j].name == rule.tag then
--         --                             tag_exists = true
--         --                     end
--         --             end
--         --             if not tag_exists then
--         --                     awful.tag.add(rule.tag)
--         --             end
--         --             awful.client.movetotag(tags[c.screen][tag_index_from_name(rule.tag)], c) 
--         --     end
--         -- end
-- 
--         -- dispatch by name first (handle more specific case first)
-- end

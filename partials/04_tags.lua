-- {{{ Tags
-- get tag names from file
--
local initial_tags = {}
for line in io.lines(table.concat({config_dir, "tags.txt"}, "/")) do
  table.insert(initial_tags, line)
end
-- 
-- -- number the tag names
for T = 1, #initial_tags do
  initial_tags[T] = (T .. " " .. initial_tags[T])
end
-- -- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag(initial_tags, s, layouts[1]) 
end
-- }}}
--


-- Tag rules
--
--
--
name_rules = {
        { name = "vim", tag = "vim" }
}

local function tag_index_from_name(n) 

        for i=1, #tags[1] do
            if string.match(tags[1][i].name, n) then
                    return i
            end
        end
        return nil
end

function dispatch_tags(c)
        -- dynamic tagging
        --
        -- get client name ("title" in xterm parlance; WM_NAME in xprop)
        -- local client_name   = c.name 

        -- -- get client class (WM_NAME in xprop)
        -- local client_class  = c.name

        -- for i=1, #name_rules do
        --     local rule = name_rules[i]
        --     if string.match(client_name, rule.name) then
        --             -- name matched, move to tag
        --             --
        --             local t = awful.tag.gettags(c.screen)
        --             local tag_exists = false
        --             for j=1, #t do
        --                     if t[j].name == rule.tag then
        --                             tag_exists = true
        --                     end
        --             end
        --             if not tag_exists then
        --                     awful.tag.add(rule.tag)
        --             end
        --             awful.client.movetotag(tags[c.screen][tag_index_from_name(rule.tag)], c) 
        --     end
        -- end

        -- dispatch by name first (handle more specific case first)
end

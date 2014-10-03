-- {{{ Tags
--

-- get tag names from file
-- TODO only 12 keys will be used for tags (keyboard order).  let's make that
-- explicit
-- mytags = mytags[1:12] no table.slice builtin lua wtf
local tagslist = {}
for tag in io.lines(table.concat({config_dir, "tags.txt"}, "/")) do
        table.insert(tagslist, tag)
end


-- index tags in top-row natural keyboard order [1,2,3,...,0,'-',='].
-- this indexing corresponds to the alt+-prefixed keybindings they
-- receive elsewhere.  this gives a pretty good reasonable total of 12
-- tags per screen, and extends the number of available tags beyond the
-- awesome default of 9.
--
local mytags    = {}
local i         = 1
for key, keycode in pairs(top_row_keycodes) do
        mytags[i] = "  " .. tagslist[i] .. " "
        i = i+1
end


-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag(mytags, s, layouts[1]) 
end

keycodes_to_tags = {}
local i=1
for key, keycode in pairs(top_row_keycodes) do
        keycodes_to_tags[keycode] = tags[1][i]
        i=i+1
end

function countTableSize(table)
    local n = 0
    for k, v in pairs(table) do
        n = n + 1
    end
    return n
end


--log(countTableSize(top_row_keycodes))
--log(countTableSize(mytags))
--log(countTableSize(tags[1]))
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

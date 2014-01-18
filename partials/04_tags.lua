-- {{{ Tags
-- get tag names from file
--
tag_names = {}
for line in io.lines(table.concat({config_dir, "tags.txt"}, "/")) do
  table.insert(tag_names, line)
end
-- 
-- -- number the tag names
for T = 1, #tag_names do
  tag_names[T] = (T .. " " .. tag_names[T])
end
-- -- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag(tag_names, s, layouts[1]) 
end
-- }}}

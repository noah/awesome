-- {{{ Key bindings


clientkeys = awful.util.table.join(
    -- fullscreen client toggle
    --
    keydoc.group("Client keys"),
      -- awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end, "toggle fullscreen"),
      awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end, "kill"),
      awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     , "toggle floating"),
      awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end, "get master"),
      awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        , "move to other screen"),
      awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end, "toggle on-top"),

      -- maximize client toggle (M)
      awful.key({ modkey, "Shift"   }, "m",
          function (c)
              c.maximized_horizontal = not c.maximized_horizontal
              c.maximized_vertical   = not c.maximized_vertical
          end, "toggle maximized"),

      -- minimize client (N)
      awful.key({ modkey, "Shift"   }, "n",
          function (c)
              -- The client currently has the input focus, so it cannot be
              -- minimized, since minimized clients can't have the focus.
              c.minimized = true
          end, "minimize client")

)

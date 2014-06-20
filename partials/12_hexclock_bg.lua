-- a timer to dynamically set the awesome window manager background
-- every 1 second.
--
-- the background color is based on the hexadecimal value of the current
-- time mapped to rgb.  this algorithm mimics the same effect as this
-- JS version:
--
-- http://colorclock.nogoodatcoding.com/
--
-- which is in turn based on a flash version, here:
--
-- http://thecolourclock.co.uk/
--
-- the below algorithm should produce the same exact colors as the above two
--
-- DEPENDENCIES:
--
--  hsetroot (though it's probably possible to accomplish same using
--  esetroot, feh, or something else)

function num2hex(num)
  local hexstr = '0123456789abcdef'
  local s = ''
  while num > 0 do
    local mod = math.fmod(num, 16)
    s = string.sub(hexstr, mod+1, mod+1) .. s
    num = math.floor(num / 16)
  end
  if s == '' then s = '0' end
  return s
end

function addLeadingZero(n)
  if(string.len(n) < 2) then return '0' .. n end
  return n
end

function timeToHex(n, fact)
  n = n*fact
  if (n < 0) then
    n = 0xFFFFFFFF + n + 1
  end
  return num2hex( n )
end

local over60  = 256/60;
local over24  = 256/24;
local hext = timer({timeout=1})
hext:connect_signal("timeout", function ()
  local dt      = os.date("*t")
  local h       = addLeadingZero(timeToHex(dt.hour, over24))
  local m       = addLeadingZero(timeToHex(dt.min, over60))
  local s       = addLeadingZero(timeToHex(dt.sec, over60))
  local hex     = '"#' .. h .. m .. s .. '"'
  -- log(hex)
  awful.util.spawn('hsetroot -solid ' .. hex)
end)
hext:start()

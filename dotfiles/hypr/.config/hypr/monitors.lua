-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

local omarchy_gdk_scale = 1
local omarchy_monitor_scale = 1.2

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = omarchy_monitor_scale })

-- Configure a specific monitor.
-- hl.monitor({ output = "DP-2", mode = "2560x1440@144", position = "0x0", scale = 1 })

-- Portrait/rotated secondary monitor (transform: 1 = 90°, 3 = 270°).
-- hl.monitor({ output = "DP-2", mode = "preferred", position = "auto", scale = 1, transform = 1 })

-- Huawei Matebook internal panel (eDP-1).
hl.monitor({ output = "desc:California Institute of Technology 0x1309", mode = "3000x2000", position = "auto", scale = 2 })

-- Office: U2721DE landscape, U2719D rotated portrait up and to its right.
hl.monitor({ output = "desc:Dell Inc. DELL U2721DE 8VWVQ83", mode = "2560x1440", position = "0x0", scale = 1 })
hl.monitor({ output = "desc:Dell Inc. DELL U2719D 1DWLX13", mode = "2560x1440", position = "2560x-700", scale = 1, transform = 1 })

-- Casa Jordi.
hl.monitor({ output = "desc:Dell Inc. DELL U2713HM GK0KD345A4GL", mode = "2560x1440", position = "-2560x0", scale = 1 })

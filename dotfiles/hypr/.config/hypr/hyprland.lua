-- Learn how to configure Hyprland: https://wiki.hypr.land/Configuring/Start/

-- Omarchy's bootstrap keeps path setup out of this user config.
dofile((os.getenv("OMARCHY_PATH") or "/usr/share/omarchy") .. "/default/hypr/bootstrap.lua")

-- Disable all Omarchy default bindings. Add your own in hypr/bindings.lua.
-- omarchy_default_bindings = false
--
-- Or disable only bindings for Omarchy's preinstalled apps/web apps while
-- keeping core window-manager bindings:
-- omarchy_preinstalled_bindings = false

-- Load Omarchy defaults.
require("default.hypr.omarchy")

-- Put your personal overrides in these files. They're loaded after Omarchy's
-- defaults so package updates can improve the defaults without rewriting your
-- ~/.config/hypr files.
require("hypr.monitors")
require("hypr.input")
require("hypr.bindings")
require("hypr.looknfeel")
require("hypr.autostart")

-- Toggle config flags dynamically.
require("default.hypr.toggles")

-- Add any other personal Hyprland configuration below.
-- o.window("qemu", { workspace = "5" })

-- Float the webcam control panel. "floating-window" is quattro's own tag for
-- this, applied in default/hypr/apps/system.lua (float + center + 875x600).
o.window("hu.irl.cameractrls", { tag = "+floating-window" })

-- Let SDL apps and games run natively on Wayland.
hl.env("SDL_VIDEODRIVER", "wayland")

-- JetBrains IDEs: native Wayland instead of XWayland, and let the IDE render at
-- the monitor's real scale rather than applying its own Java-side scaling on top
-- (monitors.lua already runs eDP-1 at 1.2).
hl.env(
  "JBR_JAVA_OPTIONS",
  "-Dawt.toolkit.name=WLToolkit -Dsun.java2d.uiScale.enabled=false -Djb.wayland.enabled=true"
)

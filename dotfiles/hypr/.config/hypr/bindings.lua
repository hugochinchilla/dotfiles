-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

-- Throw the current workspace to the monitor on either side.
o.bind("SUPER + Z", "Move workspace to previous monitor", hl.dsp.workspace.move({ monitor = "-1" }))

-- SUPER + X is "Universal cut" in quattro's clipboard bindings.
hl.unbind("SUPER + X")
o.bind("SUPER + X", "Move workspace to next monitor", hl.dsp.workspace.move({ monitor = "+1" }))

-- Jump back to the workspace you came from.
o.bind("SUPER + Q", "Former workspace", hl.dsp.focus({ workspace = "previous" }))

-- Close window. Quattro's own SUPER + W stays bound alongside this.
o.bind("SUPER + SHIFT + Q", "Close window", hl.dsp.window.close())

-- SUPER + SPACE is the Omarchy menu in quattro's utilities bindings. The menu
-- is still reachable from the bar's menu widget and SUPER + SHIFT + code:201.
hl.unbind("SUPER + SPACE")
o.bind("SUPER + SPACE", "Toggle window floating/tiling", hl.dsp.window.float({ action = "toggle" }))

-- Application launcher. The legacy binding called omarchy-launch-walker; walker
-- is gone in quattro and the launcher is now the Quickshell apps menu, which
-- quattro also keeps on SUPER + ALT + SPACE.
o.bind("SUPER + D", "Application launcher", "omarchy-menu toggle apps")

-- Move the active window to a workspace WITHOUT following it there.
-- Quattro binds SUPER + SHIFT + <n> to the following variant and keeps the
-- silent one on SUPER + SHIFT + ALT + <n>; swap the plain chord to silent.
for workspace = 1, 10 do
  local key = "SUPER + SHIFT + code:" .. tostring(workspace + 9)
  hl.unbind(key)
  o.bind(
    key,
    "Move window to workspace " .. workspace,
    hl.dsp.window.move({ workspace = tostring(workspace), follow = false })
  )
end

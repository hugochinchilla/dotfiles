-- Global workspace numbering, in place of Omarchy's per-monitor blocks
-- (default/hypr/monitor-workspaces.lua, which gives every monitor its own 1-10
-- and renumbers workspaces into blocks of ten). Here Super+N is workspace N
-- wherever it lives, as Hyprland does on its own, so a workspace keeps its
-- number when it moves monitors and Super+N focuses it from any monitor.
--
-- Same interface as the default module, so default/hypr/bindings/tiling.lua
-- and the bar's `o.workspaces.focus(slot, monitor)` dispatch keep working.
-- hyprland.lua installs it under the default module's name before
-- default.hypr.omarchy loads, so the default's monitor hooks never run.

local M = { slots = 10 }

function M.workspace_id(_, slot)
  return slot
end

function M.focus(slot)
  return hl.dsp.focus({ workspace = tostring(slot) })
end

function M.move_window(slot, follow)
  return hl.dsp.window.move({ workspace = tostring(slot), follow = follow ~= false })
end

function M.move_to_monitor(direction)
  return hl.dsp.workspace.move({ monitor = direction })
end

function M.move_window_to_monitor(direction)
  return hl.dsp.window.move({ monitor = direction })
end

function M.reconcile() end

o.workspaces = M

return M

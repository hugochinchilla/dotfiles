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

-- Each connected monitor's identity (its description), keyed by connector.
-- default/hypr/monitor-settings.lua calls this to apply the monitor panel's
-- saved choices; identical monitors get " #2", " #3" in connector order, as
-- the default module names them.
-- ponytail: no memory of who was #1, so unplugging one of an identical pair
-- can swap their saved settings; copy the default's `current` table if it does.
function M.identities()
  local monitors = {}
  for _, monitor in ipairs(hl.get_monitors()) do
    if not monitor.is_mirror then
      monitors[#monitors + 1] = monitor
    end
  end
  table.sort(monitors, function(left, right) return left.name < right.name end)

  local identities, taken = {}, {}
  for _, monitor in ipairs(monitors) do
    local described = monitor.description or ""
    described = described ~= "" and described or monitor.name
    local identity, count = described, 1
    while taken[identity] do
      count = count + 1
      identity = described .. " #" .. count
    end
    identities[monitor.name] = identity
    taken[identity] = true
  end

  return identities
end

o.workspaces = M

return M

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

-- Float browser popups that only get their real title after the window opens.
-- Window rules are matched at open time, when a Bitwarden or Google sign-in
-- popup is still an ordinary untitled browser window, so they cannot catch it:
-- https://github.com/hyprwm/Hyprland/issues/3835
-- Sizes are percentages of the monitor, as scripts/float-popups used to do.
local popup_rules = {
  -- Bitwarden vault prompt.
  { width = 30, height = 54, patterns = {
    "^Bitwarden$",
    "%(Bitwarden.*Password Manager%) %- Bitwarden",
    "%(Bitwarden.*Administrador de contraseñas%) %- Bitwarden",
  } },
  -- Google sign-in.
  -- { width = 25, height = 54, patterns = { "^Sign [Ii]n %- Google Accounts" } },
  -- MetaMask.
  -- { width = 25, height = 54, patterns = { "^Extension: %(MetaMask%)" } },
}

hl.on("window.title", function(window)
  -- Already floating means Omarchy's own open-time rules caught it (they do for
  -- Chromium, which gives the popup its own class); leave their sizing alone.
  if window.floating then
    return
  end

  local title = window.title or ""

  for _, rule in ipairs(popup_rules) do
    for _, pattern in ipairs(rule.patterns) do
      if title:match(pattern) then
        local monitor = window.monitor or hl.get_active_monitor()
        if not monitor then
          return
        end

        -- monitor.width/height are mode pixels, window geometry is logical.
        local target = "address:" .. window.address
        hl.dispatch(hl.dsp.window.float({ action = "on", window = target }))
        hl.dispatch(hl.dsp.window.resize({
          window = target,
          x = math.floor(monitor.width / monitor.scale * rule.width / 100),
          y = math.floor(monitor.height / monitor.scale * rule.height / 100),
          relative = false,
        }))
        hl.dispatch(hl.dsp.window.center({ window = target }))
        return
      end
    end
  end
end)

-- Let SDL apps and games run natively on Wayland.
hl.env("SDL_VIDEODRIVER", "wayland")

-- JetBrains IDEs: native Wayland instead of XWayland, and let the IDE render at
-- the monitor's real scale rather than applying its own Java-side scaling on top
-- (monitors.lua already runs eDP-1 at 1.2).
hl.env(
  "JBR_JAVA_OPTIONS",
  "-Dawt.toolkit.name=WLToolkit -Dsun.java2d.uiScale.enabled=false -Djb.wayland.enabled=true"
)

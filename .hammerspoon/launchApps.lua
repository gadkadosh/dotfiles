-- Keybindings for starting apps
appShortcuts = {
  { key = "h", app = "Safari" },
  { key = "j", app = "Terminal" },
  { key = "f", app = "Finder" },
  { key = "m", app = "Messages" },
  { key = "n", app = "Activity Monitor" },
}

toggleApp = function(app)
  return function()
    if not hs.application.launchOrFocus(app) then
      hs.application.launchOrFocusByBundleID(app)
    end
  end
end

for i, binding in ipairs(appShortcuts) do
  hs.hotkey.bind({"alt", "shift"}, binding.key, toggleApp(binding.app))
end

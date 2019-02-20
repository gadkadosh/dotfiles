-- Cmd+Alt+Ctrl+R: Reload Hammerspoon config
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "R", function()
  hs.reload()
end)
hs.alert.show("Config reloaded")

-- Cmd+Alt+Ctrl+E: Toggle Hammerspoon console
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "E", function()
  hs.toggleConsole()
end)

-- Shortcuts for opening/switching to apps
require('launchApps')

-- Window management
require('winManagement')

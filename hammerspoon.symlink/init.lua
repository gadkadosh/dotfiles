
-- For Miro's position module
hyper = {"shift", "alt", "cmd"}
-- hyper = {"ctrl", "alt", "cmd"}
hypershift = {"ctrl", "alt", "cmd", "shift"}

-- Shortcuts for opening/switching to apps
require('launchApps')

-- Displays what's in the clipboard
require('clipboard')

-- Lowers the volume to 0 when outside of my WiFi
require('homeWifi')

-- Maps fn + hjkl to arrow keys
-- require('hjklArrows')

-- Miro's position module, better than what I started writing at winManagement.lua
require('position')

-- Move windows with keys
require('winMov')

-- Disable the annoyind Cmd+I shortcut in Safari, which keeps firing up Mail.app
-- require('disableKeys')

-- Cmd+Alt+Ctrl+R: Reload Hammerspoon config
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
    hs.reload()
end)
hs.alert.show("Config reloaded")

-- Cmd+Alt+Ctrl+E: Toggle Hammerspoon console
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "E", function()
    hs.toggleConsole()
end)

-- hs.loadSpoon(FnMate)

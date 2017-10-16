ctrlaltcmd = {"ctrl", "alt", "cmd"}
ctrlaltcmdshift = {"ctrl", "alt", "cmd", "shift"}
appLaunchMeta = {"alt", "shift"}

-- Cmd+Alt+Ctrl+R: Reload Hammerspoon config
hs.hotkey.bind(ctrlaltcmd, "R", function()
    hs.reload()
end)
hs.alert.show("Config reloaded")

-- Cmd+Alt+Ctrl+E: Toggle Hammerspoon console
hs.hotkey.bind(ctrlaltcmd, "E", function()
    hs.toggleConsole()
end)

-- Shortcuts for opening/switching to apps
require('launchApps')

-- Window management
require('winManagement')

-- Displays what's in the clipboard
require('clipboard')

-- Lowers the volume to 0 when outside of my WiFi
require('homeWifi')

-- Maps fn + hjkl to arrow keys
require('fnMeta')

-- Disable the annoyind Cmd+I shortcut in Safari, which keeps firing up Mail.app
require('appWatcher')

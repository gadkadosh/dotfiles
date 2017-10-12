
-- Setup keybindings for starting apps
appShortcuts = {
    {key = "h", name = "Safari"},
    {key = "j", name = "Terminal"},
    {key = "k", id = "com.microsoft.VSCode"},
    {key = "l", name = "Finder"},
    {key = "m", name = "Messages"},
    {key = "p", name = "Spotify"},
}

-- Meta keys to use for the bindings
local launcherMeta = {"cmd", "shift"}

for i, val in ipairs(appShortcuts) do
    hs.hotkey.bind(launcherMeta, val.key, function()
        if (val.id) then
            hs.application.launchOrFocusByBundleID(val.id)
        elseif (val.name) then
            hs.application.launchOrFocus(val.name)
        end
    end)
end

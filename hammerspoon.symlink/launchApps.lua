
-- Setup keybindings for starting apps
appShortcuts = {
    { key = "h", id = "Safari", start = true },
    { key = "j", id = "Terminal", start = true },
    { key = "k", id = "Visual Studio Code", start = false },
    { key = "l", id = "Finder", start = true },
    { key = "m", id = "Messages", start = true },
    { key = "n", id = "Activity Monitor", start = true },
    { key = "p", id = "Spotify", start = true },
}

toggleApp = function(binding)
    return function()
        app = hs.application.find(binding.id)

        -- If it is running and is frontmost, hide
        if app and app:isFrontmost() then
            app:hide()
            return
        end

        -- If it isn't running, do we want to start it?
        if not app and not binding.start then
            return
        end

        -- Else, if not frontmost or not running, refocus or open
        if not hs.application.launchOrFocus(binding.id) then
            hs.application.launchOrFocusByBundleID(binding.id)
        end
    end
end

for i, val in ipairs(appShortcuts) do
    hs.hotkey.bind(appLaunchMeta, val.key, toggleApp(val))
end

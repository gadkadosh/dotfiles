
-- Setup keybindings for starting apps
appShortcuts = {
    {key = "h", id = "Safari"},
    {key = "j", id = "Terminal"},
    {key = "k", id = "com.microsoft.VSCode"},
    {key = "l", id = "Finder"},
    {key = "m", id = "Messages"},
    {key = "n", id = "Activity Monitor"},
    {key = "p", id = "Spotify"},
}

toggleApp = function(binding)
    return function()
        app = hs.application.find(binding.id)

        -- If it is running and is frontmost, hide
        if app and app:isFrontmost() then
            app:hide()
        -- Else, if not frontmost or not running, refocus or open
        else
            if not hs.application.launchOrFocus(binding.id) then
                hs.application.launchOrFocusByBundleID(binding.id)
            end
        end
    end
end

for i, val in ipairs(appShortcuts) do
    hs.hotkey.bind(appLaunchMeta, val.key, toggleApp(val))
end

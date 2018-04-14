-- Setup keybindings for starting apps
appShortcuts = {
    { key = "h", app = "Safari", start = true },
    { key = "j", app = "Terminal", start = true },
    { key = "f", app = "Finder", start = true },
    { key = "m", app = "Messages", start = true },
    { key = "n", app = "Activity Monitor", start = true },
}

toggleApp = function(binding)
    return function()
        -- hs.application.enableSpotlightForNameSearches(true)

        -- If it is running and is frontmost, hide
        -- app = hs.application.find(binding.app)
        -- if app and app:isFrontmost() then
        --     app:hide()
        --     return
        -- end

        -- If it isn't running, do we want to start it?
        -- if not app and not binding.start then
        --     return
        -- end

        -- Else, if not frontmost or not running, refocus or open
        if not hs.application.launchOrFocus(binding.app) then
            hs.application.launchOrFocusByBundleID(binding.app)
        end
    end
end

for i, binding in ipairs(appShortcuts) do
    hs.hotkey.bind({"alt", "shift"}, binding.key, toggleApp(binding))
end

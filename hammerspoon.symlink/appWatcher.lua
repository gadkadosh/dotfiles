-- Watcher for actions when specific apps get activated
function applicationWatcherCallback(appName, eventType, appObject)

    if (appName == "Safari") then
        if (eventType == hs.application.watcher.activated) then
            -- Safari just got focus, hijack annoying Cmd-I, which opens Mail, and send Cmd-Alt-I, which toggles inspector
            hijackedKey = hs.hotkey.bind({"cmd"}, "i", function()
                differentKey = hs.eventtap.event.newKeyEvent({"cmd","alt"}, "i", true)
                differentKey:post(appObject)
            end)
        elseif (eventType == hs.application.watcher.deactivated) then
            -- Safari just lost focus, enable our hotkeys
            hijackedKey:delete()
        end

    elseif (appName == "Terminal") then
        -- When switching to Terminal switch keyboard to English
        if (eventType == hs.application.watcher.activated) then
            oldLayout = hs.keycodes.currentLayout()
            hs.keycodes.setLayout('U.S.')
        elseif (eventType == hs.application.watcher.deactivated) then
            -- Terminal got deactivated, restore last keyboard layout
            hs.keycodes.setLayout(oldLayout)
        end
    end
end

-- Create and start the application event watcher
watcher = hs.application.watcher.new(applicationWatcherCallback)
watcher:start()

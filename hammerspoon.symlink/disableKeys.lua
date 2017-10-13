-- Define a callback function to be called when application events happen
function applicationWatcherCallback(appName, eventType, appObject)
    if (appName == "Safari") then
        if (eventType == hs.application.watcher.activated) then
            -- Safari just got focus, disable our hotkeys
            -- Hijack annoying cmd-I, which opens Mail, and send Cmd-Alt-I, which toggles inspector
            hijackedKey = hs.hotkey.bind({"cmd"}, "i", function()
                differentKey = hs.eventtap.event.newKeyEvent({"cmd","alt"}, "i", true)
                differentKey:post(appObject)
            end)
        elseif (eventType == hs.application.watcher.deactivated) then
            -- Safari just lost focus, enable our hotkeys
            hijackedKey:delete()
        end
    end
end

-- Create and start the application event watcher
watcher = hs.application.watcher.new(applicationWatcherCallback)
watcher:start()


unusedKey = hs.hotkey.modal.new({"cmd"}, "i")

unusedKey:bind({"cmd", "alt"}, "i", function() end)

-- Define a callback function to be called when application events happen
function applicationWatcherCallback(appName, eventType, appObject)
    if (appName == "Safari") then
        if (eventType == hs.application.watcher.activated) then
            -- Safari just got focus, disable our hotkeys
            unusedKey:exit()
        elseif (eventType == hs.application.watcher.deactivated) then
            -- Safari just lost focus, enable our hotkeys
            unusedKey:enter()
        end
    end
end

-- Create and start the application event watcher
watcher = hs.application.watcher.new(applicationWatcherCallback)
watcher:start()

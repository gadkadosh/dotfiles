-- eventually I would put a few defaults here
layoutStore = {

}

-- When changing keyboard layout save it for the current frontmost app
hs.keycodes.inputSourceChanged(function()
    local activeApp = hs.application.frontmostApplication():name()
    print('saving for ', activeApp, hs.keycodes.currentLayout())
    layoutStore[activeApp] = hs.keycodes.currentLayout()
end)

-- Callback for application.watcher
function applicationWatcherCallback(appName, eventType, appObject)
    -- Safari is active, hijack Cmd-I and reroute to Alt-Cmd-I
    if appName == "Safari" then
        if eventType == hs.application.watcher.activated then
            hijackedKey = hs.hotkey.bind({"cmd"}, "i", function()
                differentKey = hs.eventtap.event.newKeyEvent({"cmd","alt"}, "i", true)
                differentKey:post(appObject)
            end)
        elseif eventType == hs.application.watcher.deactivated then
            hijackedKey:delete()
        end
    end

    -- Check if we need to change Keyboard Layout for an activated/deactivated application
    if eventType == hs.application.watcher.activated then
        if layoutStore[appName] and
            hs.keycodes.currentLayout() ~= layoutStore[appName] then
            print('setting for ', appName, layoutStore[appName])
            hs.keycodes.setLayout(layoutStore[appName])
        elseif not layoutStore[appName] then
            layoutStore[appName] = hs.keycodes.currentLayout()
            print('Saving first time for ', appName, layoutStore[appName])
        end
    end

end

-- Create and start the application event watcher
watcher = hs.application.watcher.new(applicationWatcherCallback)
watcher:start()

-- Set Keyboard Layout to English when Spotlight is called
-- (Spotlight need this method because its not recognized as an application)
slFilt = hs.window.filter.new('Spotlight')
slFilt:subscribe(hs.window.filter.windowCreated, function()
    slLastLayout = hs.keycodes.currentLayout()
    hs.keycodes.setLayout('U.S.')
end)
-- reset keyboard layout to what it was before Spotlight was called
slFilt:subscribe(hs.window.filter.windowDestroyed, function()
    hs.keycodes.setLayout(slLastLayout)
end)

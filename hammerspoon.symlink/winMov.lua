
local moveMeta = {"cmd", "alt", "ctrl", "shift"}

-- Move window left
hs.hotkey.bind(moveMeta, "Left", function()
    local window = hs.window.focusedWindow()
    local f = window:frame()
    f.x = f.x - 20
    window:setFrame(f)
end)

-- Move window to the right
hs.hotkey.bind(moveMeta, "Right", function()
    local window = hs.window.focusedWindow()
    local f = window:frame()
    f.x = f.x + 20
    window:setFrame(f)
end)

-- Move window to the up
hs.hotkey.bind(moveMeta, "Up", function()
    local window = hs.window.focusedWindow()
    local f = window:frame()
    f.y = f.y - 20
    window:setFrame(f)
end)

-- Move window to the down
hs.hotkey.bind(moveMeta, "Down", function()
    local window = hs.window.focusedWindow()
    local f = window:frame()
    f.y = f.y + 20
    window:setFrame(f)
end)

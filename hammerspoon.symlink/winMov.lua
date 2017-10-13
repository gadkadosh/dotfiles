-- Move window left
hs.hotkey.bind(ctrlaltcmdshift, "Left", function()
    local window = hs.window.focusedWindow()
    local f = window:frame()
    f.x = f.x - 20
    window:setFrame(f)
end)

-- Move window to the right
hs.hotkey.bind(ctrlaltcmdshift, "Right", function()
    local window = hs.window.focusedWindow()
    local f = window:frame()
    f.x = f.x + 20
    window:setFrame(f)
end)

-- Move window to the up
hs.hotkey.bind(ctrlaltcmdshift, "Up", function()
    local window = hs.window.focusedWindow()
    local f = window:frame()
    f.y = f.y - 20
    window:setFrame(f)
end)

-- Move window to the down
hs.hotkey.bind(ctrlaltcmdshift, "Down", function()
    local window = hs.window.focusedWindow()
    local f = window:frame()
    f.y = f.y + 20
    window:setFrame(f)
end)

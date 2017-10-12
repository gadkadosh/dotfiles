
hs.window.animationDuration = 0

-- Full screen
hs.hotkey.bind({"cmd", "alt"}, "f", function()
    local window = hs.window.focusedWindow()
    local f = window:frame()
    local screen = window:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y
    f.w = max.w
    f.h = max.h
    window:setFrame(f)
end)

-- Window resize left 50%
hs.hotkey.bind({"cmd", "alt"}, "Left", function()
    local window = hs.window.focusedWindow()
    local f = window:frame()
    local screen = window:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    window:setFrame(f)
end)

-- Window resize right 50%
hs.hotkey.bind({"cmd", "alt"}, "Right", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x + (max.w / 2)
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    win:setFrame(f)
end)

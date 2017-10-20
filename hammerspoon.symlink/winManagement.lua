-- Modified from https://github.com/wincent/wincent.git

-- 12x12 grid allows for halves and thirds
hs.grid.setGrid('12x12')
hs.grid.MARGINX = 0
hs.grid.MARGINY = 0
-- No animations
hs.window.animationDuration = 0

-- All options
local grid = {
    topHalf = '0,0 12x6',
    topThird = '0,0 12x4',
    topTwoThirds = '0,0 12x8',
    rightHalf = '6,0 6x12',
    rightThird = '8,0 4x12',
    rightTwoThirds = '4,0 8x12',
    bottomHalf = '0,6 12x6',
    bottomThird = '0,8 12x4',
    bottomTwoThirds = '0,4 12x8',
    leftHalf = '0,0 6x12',
    leftThird = '0,0 4x12',
    leftTwoThirds = '0,0 8x12',
    topLeft = '0,0 6x6',
    topRight = '6,0 6x6',
    bottomRight = '6,6 6x6',
    bottomLeft = '0,6 6x6',
    fullScreen = '0,0 12x12',
    centeredLarge = '1,1 10x10',
    centeredMedium = '2,2 8x8',
    centeredSmall = '3,3 6x6',
}

-- The keybindings
local ctrlalt = {"ctrl", "alt"}
local ctrlaltcmd = {"ctrl", "alt", "cmd"}
local switchMeta = {"cmd", "ctrl"}

local keyBindings = {
    {
        meta = ctrlalt,
        key = "up",
        chain = { grid.topHalf, grid.topThird, grid.topTwoThirds }
    },
    {
        meta = ctrlalt,
        key = "right",
        chain = { grid.rightHalf, grid.rightThird, grid.rightTwoThirds }
    },
    {
        meta = ctrlalt,
        key = "down",
        chain = { grid.bottomHalf, grid.bottomThird, grid.bottomTwoThirds }
    },
    {
        meta = ctrlalt,
        key = "left",
        chain = { grid.leftHalf, grid.leftThird, grid.leftTwoThirds }
    },
    {
        meta = ctrlaltcmd,
        key = "up",
        chain = { grid.topLeft, grid.topRight, grid.bottomRight, grid.bottomLeft }
    },
    {
        meta = ctrlaltcmd,
        key = "down",
        chain = { grid.fullScreen, grid.centeredLarge, grid.centeredMedium, grid.centeredSmall }
    }
}

chain = (function(movements)
    local cycleLength = #movements
    local sequenceIndex = 1
    local timeInterval = 2

    return function()
        local win = hs.window.frontmostWindow()
        local id = win:id()
        local now = hs.timer.secondsSinceEpoch()

        if
            lastMovements ~= movements or
            lastWindow ~= id or
            now - timeInterval > lastTime
            then
            sequenceIndex = 1
        end

        hs.grid.set(win, movements[sequenceIndex])
        lastWindow = id
        lastMovements = movements
        sequenceIndex = sequenceIndex % cycleLength + 1
        lastTime = now
    end
end)

for i, val in pairs(keyBindings) do
    hs.hotkey.bind(val.meta, val.key, chain(val.chain))
end

-- Move windows
local movOffset = 20
local moveMeta = ctrlaltcmdshift

local movBindings = {
    { key = "Left", axis = "x", change = -movOffset },
    { key = "Right", axis = "x", change = movOffset },
    { key = "Up", axis = "y", change = -movOffset },
    { key = "Down", axis = "y", change = movOffset },
}

local movWindow = function(binding)
    return (function()
        local win = hs.window.frontmostWindow()
        local f = win:frame()
        f[binding.axis] = f[binding.axis] + binding.change
        win:setFrame(f)
    end)
end

for i, val in pairs(movBindings) do
    hs.hotkey.bind(moveMeta, val.key, movWindow(val), nil, movWindow(val))
end

-- Switch windows
hs.hotkey.bind(switchMeta, "Left", hs.window.focusWindowWest)
hs.hotkey.bind(switchMeta, "h", hs.window.focusWindowWest)
hs.hotkey.bind(switchMeta, "Up", hs.window.focusWindowNorth)
hs.hotkey.bind(switchMeta, "k", hs.window.focusWindowNorth)
hs.hotkey.bind(switchMeta, "Right", hs.window.focusWindowEast)
hs.hotkey.bind(switchMeta, "l", hs.window.focusWindowEast)
hs.hotkey.bind(switchMeta, "Down", hs.window.focusWindowSouth)
hs.hotkey.bind(switchMeta, "j", hs.window.focusWindowSouth)

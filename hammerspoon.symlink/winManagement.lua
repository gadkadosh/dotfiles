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
    centeredLarge = '2,2 8x8',
    centeredSmall = '3,3 6x6',
}

-- The keybindings
local ctrlalt = {"ctrl", "alt"}
local ctrlaltcmd = {"ctrl", "alt", "cmd"}

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
        chain = { grid.leftHalf, grid.leftThird, grid.leftTwoThirds }
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
        chain = { grid.fullScreen, grid.centeredLarge, grid.centeredSmall }
    }
}

-- local lastMovements = nil

chain = (function(movements)
    local sequenceIndex = 1
    local cycleLength = #movements

    return function()
        local win = hs.window.frontmostWindow()
        if lastMovements ~= movements then
            sequenceIndex = 1
        end
        hs.grid.set(win, movements[sequenceIndex])
        lastMovements = movements
        sequenceIndex = sequenceIndex % cycleLength + 1
    end
end)


for i, val in pairs(keyBindings) do
    hs.hotkey.bind(val.meta, val.key, chain(val.chain))
end

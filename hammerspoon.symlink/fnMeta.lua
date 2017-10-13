
-- Catch fn-hjkl keys and converts them to arrow keys.
function catcher(event)
    if event:getFlags()['fn'] and event:getCharacters() == "h" then
       return true, {hs.eventtap.event.newKeyEvent({}, "left", true)}
    end
    if event:getFlags()['fn'] and event:getCharacters() == "j" then
       return true, {hs.eventtap.event.newKeyEvent({}, "down", true)}
    end
    if event:getFlags()['fn'] and event:getCharacters() == "k" then
       return true, {hs.eventtap.event.newKeyEvent({}, "up", true)}
    end
    if event:getFlags()['fn'] and event:getCharacters() == "l" then
       return true, {hs.eventtap.event.newKeyEvent({}, "right", true)}
    end
    return false
end

local tapper = hs.eventtap.new({hs.eventtap.event.types.keyDown}, catcher):start()

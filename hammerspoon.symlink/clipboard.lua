
-- Display clipboard content when pressing Cmd+Alt+Ctrl+V
showingClipboard = false
function showClipBoardContent ()
    if showingClipboard then
        -- hs.alert.closeAll()
        hs.alert.closeSpecific(clipboardAlert)
        showingClipboard = false
        return true
    end
	clipboard = hs.pasteboard.getContents()
	clipboardAlert = hs.alert.show(clipboard)
    showingClipboard = true
    hs.timer.doAfter(2, function() showingClipboard = false end)
end
hs.hotkey.bind({"Cmd", "Alt", "Ctrl"}, "v", showClipBoardContent)

local ok, comment = pcall(require, "Comment")
if not ok then
    return
end
local ok_ts, ts_context = pcall(require, "ts_context_commentstring.utils")

comment.setup {
    pre_hook = function(ctx)
        if not ok_ts then
            return
        end

        local U = require "Comment.utils"

        local location = nil
        if ctx.ctype == U.ctype.block then
            location = ts_context.get_cursor_location()
        elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
            location = ts_context.get_visual_start_location()
        end

        return require("ts_context_commentstring.internal").calculate_commentstring {
            key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
            location = location,
        }
    end,
}

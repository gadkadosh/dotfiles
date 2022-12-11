P = function(v)
    print(vim.inspect(v))
    return v
end

local ok, plenary_reload = pcall(require, "plenary.reload")

if not ok then
    return
end

RELOAD = function(...)
    return plenary_reload.reload_module(...)
end

R = function(name)
    RELOAD(name)
    return require(name)
end

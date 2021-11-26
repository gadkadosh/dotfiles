P = function(v)
    print(vim.inspect(v))
    return v
end

if pcall(require, "plenary") then
    RELOAD = function(...)
        return require("plenary.reload").reload_module(...)
    end

    R = function(name)
        RELOAD(name)
        return require(name)
    end
end

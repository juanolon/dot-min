local mode_file = vim.fn.expand('~/.background-mode')
local function toggle()
    local file, errr = io.open(mode_file, 'rb')
    -- print(err)
    if not file then return nil end
    local mode = file:read("*line")
    file:close()
    vim.opt.background = mode
end

local w = vim.loop.new_fs_event()
local on_change
local function watch_file(fname)
    w:start(fname, {}, vim.schedule_wrap(on_change))
end
on_change = function()
    toggle()
    -- Debounce: stop/start.
    w:stop()
    watch_file(mode_file)
end

-- toggle vim config when background changes
watch_file(mode_file)
toggle()

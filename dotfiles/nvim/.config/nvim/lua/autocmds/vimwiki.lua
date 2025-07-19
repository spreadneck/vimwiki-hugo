local function read_template_file(filepath)
    local lines = {}
    local expanded_path = vim.fn.expand(filepath)
    local f = io.open(expanded_path, "r")
    if not f then
        vim.api.nvim_err_writeln("Couldn't open template: " .. expanded_path)
        return lines
    end
    for line in f:lines() do
        table.insert(lines, line)
    end
    f:close()
    return lines
end

local function fill_template(tpl, replacements)
    local lines = {}
    for _, line in ipairs(tpl or {}) do
        local expanded = line
        for key, val in pairs(replacements) do
            -- Replace $KEY with val (e.g., $VIMWIKI_TITLE)
            expanded = expanded:gsub("%$" .. key, val)
        end
        table.insert(lines, expanded)
    end
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = "*/vimwiki-hugo/content/*.md",
    callback = function(args)
        local filename = vim.fn.fnamemodify(args.file, ":t:r")
        local today = os.date("%Y-%m-%d")
        if string.find(args.file, "/posts/") then
            local tpl = read_template_file("~/vimwiki-hugo/templates/diary.md")
            fill_template(tpl, {
                DATE = filename,
                TODAY = today,
                VIMWIKI_TITLE = filename:gsub("_", " ")
            })
        else
            local tpl = read_template_file("~/vimwiki-hugo/templates/default.md")
            fill_template(tpl, {
                VIMWIKI_TITLE = filename:gsub("_", " "),
                TODAY = today
            })
        end
    end
})

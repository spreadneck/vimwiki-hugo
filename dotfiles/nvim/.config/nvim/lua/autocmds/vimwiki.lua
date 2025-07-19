local function fill_template(tpl, replacements)
  local lines = {}
  for _, line in ipairs(tpl or {}) do
    local expanded = line
    for key, val in pairs(replacements) do
      expanded = expanded:gsub("%%" .. key .. "%%", val)
    end
    table.insert(lines, expanded)
  end
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*/vimwiki-hugo/content/*.md",
  callback = function(args)
    local filename = vim.fn.fnamemodify(args.file, ":t:r")
    local title = filename:gsub("_", " ")
    local today = os.date("%Y-%m-%d")
    if string.find(args.file, "/posts/") then
      fill_template(vim.g.vimwikidiarytemplates.default, {
        filename = title,
        date = today,
      })
    else
      fill_template(vim.g.vimwikitemplates.default, { filename = title })
    end
  end,
})

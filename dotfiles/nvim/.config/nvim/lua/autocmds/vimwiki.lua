vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*/vimwiki-hugo/content/posts/*.md",
  callback = function()
    local date = os.date("%Y-%m-%d")
    local lines = {
      "---",
      'title: "' .. date .. '"',
      "date: " .. date,
      "draft: false",
      "---",
      "",
    }
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  end,
})

vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*/vimwiki-hugo/content/docs/*.md",
  callback = function(args)
    local filename = vim.fn.fnamemodify(args.file, ":t:r")
    local title = filename:gsub("_", " ")
    local lines = {
      "---",
      'title: "' .. title .. '"',
      "draft: false",
      "---",
      "",
    }
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  end,
})

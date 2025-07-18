vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*/vimwiki-hugo/content/posts/*.md",
  callback = function(args)
    local filename = vim.fn.fnamemodify(args.file, ":t:r")  -- filename without extension
    -- Check if filename is a date (YYYY-MM-DD)
    local date_pattern = "(%d%d%d%d%-%d%d%-%d%d)"
    local title
    local today = os.date("%Y-%m-%d")
    if filename:match(date_pattern) then
      -- Use the date in the filename as the title
      title = filename:match(date_pattern)
    else
      -- Fallback: Make a more readable title (replace underscores with spaces)
      title = filename:gsub("_", " ")
    end
    local lines = {
      "---",
      'title: "' .. title .. '"',
      "date: " .. today,
      "draft: true",
      "---",
      "",
    }
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  end,
})

vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*/vimwiki-hugo/content:/*.md",
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

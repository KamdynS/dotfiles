local options = {
  defaults = {
    file_ignore_patterns = {
      "Downloads/.*",
      "downloads/.*",
      "node_modules/.*",
      ".git/.*",
    },
  },
  pickers = {
    live_grep = {
      additional_args = function()
        return {"--glob", "!Downloads/**", "--glob", "!downloads/**"}
      end
    }
  }
}

return options

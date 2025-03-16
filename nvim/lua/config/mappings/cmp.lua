local cmp = require("cmp")
local LazyVim = require("lazyvim.util")

local cmp_mappings = cmp.mapping.preset.insert({
  ["<C-b>"] = cmp.mapping.scroll_docs(-4),
  ["<C-f>"] = cmp.mapping.scroll_docs(4),
  ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
  ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
  ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }), -- Custom keymap for Down
  ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }), -- Custom keymap for Up
  ["<Tab>"] = cmp.mapping.confirm({ select = true }), -- Tab to confirm selection
  ["<C-Space>"] = cmp.mapping.complete(),
  ["<CR>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      fallback() -- Ignore Enter if completion is visible
    else
      fallback()
    end
  end),
  ["<C-y>"] = LazyVim.cmp.confirm({ select = true }),
  ["<S-CR>"] = LazyVim.cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }),
  ["<C-CR>"] = function(fallback)
    cmp.abort()
    fallback()
  end,
  ["<tab>"] = function(fallback)
    return LazyVim.cmp.map({ "snippet_forward", "ai_accept" }, fallback)()
  end,
})

return cmp_mappings

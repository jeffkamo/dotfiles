local status, osc52 = pcall(require, "nvim-osc52")
if (not status) then return end

osc52.setup({})

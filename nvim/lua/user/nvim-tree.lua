local M = {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
}

function M.config()
    local tree = require("nvim-tree")

    tree.setup {}
end

return M

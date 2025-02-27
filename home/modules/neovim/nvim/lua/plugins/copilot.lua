return {
    {
        "zbirenbaum/copilot.lua",
        enabled = false,
        event = "BufEnter",
        opts = {
            suggestion = { enabled = true },
            panel = { enabled = true },
        },
    },
    {
        "zbirenbaum/copilot-cmp",
        enabled = true,
        opts = {}
    }
}

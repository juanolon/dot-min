return {
    {
        "joeveiga/ng.nvim",
        keys = {
            {
                "<leader>at",
                function()
                    require("ng").goto_template_for_component()
                end,
                desc = "Go to template for component",
            },
            {
                "<leader>ac",
                function()
                    require("ng").goto_component_with_template_file()
                end,
                desc = "Go to component(s) for template",
            },
            {
                "<leader>aT",
                function()
                    require("ng").get_template_tcb()
                end,
                desc = "Display template typecheck block",
            },
        },
    }
}

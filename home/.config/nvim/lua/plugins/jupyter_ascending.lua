return {
    {
        'untitled-ai/jupyter_ascending.vim',
        ft= {'python'},
        keys = {
            {
                '<leader>x',
                '<Plug>JupyterExecute',
                desc = 'Execute cell',
                ft = 'python'
            },
            {
                '<leader>X',
                '<Plug>JupyterExecuteAll',
                desc = 'Execute all cells',
                ft = 'python'
            },
        },
    },
}

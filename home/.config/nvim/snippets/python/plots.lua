return
  {
    -- GENERIC ENVIRONMENT
    s({trig="grid_plot"},
      fmta(
        [[
        rows = <>
        cols = <>
        fig, axes = plt.subplots(rows, cols, figsize=(10, 6))
        axes = axes.flatten()
        for i in range(cols*rows):
            data = ...
            <>

            axes[i].scatter(data[:,0],data[:,1],c=y,s=25)
            axes[i].set(title=name)

        plt.tight_layout()
        plt.show()
      ]],
        {
          i(1),
          i(2),
          d(2, get_visual),
        }
      ),
      {condition = line_begin}
    ),
}

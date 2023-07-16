# treesitter-renamer

A plugin to rename files based on tree-sitter nodes.

## Rationale

You create a new markdown file. You give it a meaningful name. You keep adding stuff to it, then you change the `H1` title to better explain what's into the file. You hit `<leader>rr`, and the file gets renamed using the `H1` as a file name.

You rename a ruby on rails model using LSP. All the code gets beautifully updated, but the file name stays the same, and it messes with the autoloader. You go back to the model, hit `<leader>rr`, and the file gets renamed with the file name taken from the new model name.

## Setup

Add the following code to your `lazy` config:

```lua
    {
      "metalelf0/treesitter-renamer.nvim",
      dependencies = {
        "tpope/vim-eunuch",
      },
      config = function()
        require("treesitter-renamer").config()
      end,
    }
```

## Usage

Right now, only markdown is supported. Enter a markdown file with an H1 title, hit `<Leader>rr`, and the file will be renamed.

## Next Steps

- [ ] support more languages
- [ ] allow changing keybind

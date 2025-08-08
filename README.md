# stylize.nvim

A simple Neovim plugin to apply Unicode text styles like **bold**, *italic*, `monospace`, and more!

## ✨ Features

- Apply styles to visually selected text
- Supports: `bold`, `italic`, `bold_italic`, `monospace`
- Easy commands and keymaps

## 🛠 Installation (Lazy.nvim)

```lua
{
  "CodesWithRobi/stylize.nvim",
  config = function()
    require("stylize").setup()
  end
}
```

## How to Use

Highlight the text you want to style in visual mode
Run one of the following commands to transform it:

```lua
:Stylize bold
:Stylize italic
:Stylize bold_italic
:Stylize monospace
```

## Handy Keymaps

Use these default shortcuts to style your text on the fly (visual mode only!):


| Shortcut      | Effect         |
|--------------|----------------|
| `<leader>sb` | Make it **bold**    |
| `<leader>si` | Make it *italic*    |
| `<leader>sm` | Make it `monospace` |

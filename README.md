### Description

Based off of nvim-lua/kickstart.nvim with updates taken from NvChad/NvChad
NOTE: NvChad/NvChad could not be used directly since it uses true colors (24-bit) and macOS terminal only supports 256 (8-bit)

### Instructions

1. Install kickstart.nvim
```sh
# on Linux and Mac
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

2. To load ./custom/init.lua add the following the end of the init.lua
```lua
require('custom.init');
```

3. To load ./custom/plugins/plugins.lua uncomment the following in init.lua
```lua
{ import = 'custom.plugins' }
```

4. Install fonts with icons

on macOS (installs to ~/Library/Fonts) and verify with Font Book app
```sh
brew tap homebrew/cask-fonts && brew install --cask font-jetbrains-mono
```
or

on Linux
```sh
curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
unzip -d jet-brains-mono-nerd-font JetBrainsMono.zip
mv jet-brains-mono-nerd-font ~/.local/share/fonts/
# for macos copy *.ttf to ~/Library/Fonts
# then open Font Book to verify
fc-cache -f -v
```

### Post Installation Instructions

inside any typescript project install node types to allow lsp to read built-in types
```sh
npm install --save-dev @types/node
```

to get lsp working on redhat linux
```sh
npm install -g typescript-language-server typescript
```

[run inside nvim] to fix treesitter unable to access /usr/share/nvim/runtime/lua/
```sh
TSInstall comment
TSInstall all
```

to enable live grep (find in file)
```sh
sudo yum install ripgrep
```

startup dap server for javascript debugging in neovim
```sh
echo 'alias dap="~/.local/share/nvim/mason/packages/js-debug-adapter/js-debug-adapter 8123 127.0.0.1"' >> ~/.bashrc
```

to get clipboard
```sh
yum install xclip
```

### Links

* Effective Nerd Fonts in Multiple Terminals: https://www.youtube.com/watch?v=mQdB_kHyZn8&t=84s
* The (almost) perfect Neovim setup for Node.js: https://www.youtube.com/watch?v=CVCBHHFXWNE
* Mason package repository: https://mason-registry.dev/registry/list

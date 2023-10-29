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

    4.1 on macOS (installs to ~/Library/Fonts) and verify with Font Book app
    ```sh
    brew tap homebrew/cask-fonts && brew install --cask font-jetbrains-mono
    ```

    4.2 or on Linux
    ```sh
    curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
    unzip -d jet-brains-mono-nerd-font JetBrainsMono.zip
    mv jet-brains-mono-nerd-font ~/.local/share/fonts/
    # for macos copy *.ttf to ~/Library/Fonts
    # then open Font Book to verify
    fc-cache -f -v
    ```

5. in neovim, resync Lazy package manager
```sh
:Lazy
```

6. in neovim, import os-level dependencies via custom mason mapping
```sh
:MasonInstallAll
```

### Post Installation Instructions

* inside any typescript project install node types to allow lsp to read built-in types
```sh
npm install --save-dev @types/node
```

* to get lsp working on redhat linux
```sh
npm install -g typescript-language-server typescript
```

* in neovim, to fix treesitter unable to access /usr/share/nvim/runtime/lua/
```sh
TSInstall comment
TSInstall all
```

* to enable live grep (find in file)
```sh
sudo yum install ripgrep
```

* startup dap server for javascript debugging in neovim
```sh
echo 'alias dap="~/.local/share/nvim/mason/packages/js-debug-adapter/js-debug-adapter 8123 127.0.0.1"' >> ~/.bashrc
```

* to get clipboard
```sh
yum install xclip
```

### Tips and Tricks

Search and replace with Telscope + cdo

1. Search using telescope then after hit Ctrl-Q
2. Then replace using cdo (note: "I" means case sensitive, "c" is confirm change)or to run one command per file use :cfdo
```vimscript
:cdo s/[searched text]/[replaced text]/gIc
```

Missing propeties for lua script

1. Add the following comment to remove warning
```lua
---@diagnostic disable-next-line missing-fields
```
or update lua_ls
```lua
  lua_ls = {
    Lua = {
      diagnostics = {
        disable = { "missing-fields", "incomplete-signature-doc" },
      },
    },
  },

File not included in TSConfig eventhough it is included

1. Rename file that conflicts with a .ts version such as test.js and test.ts rename test.js to test1.js

```

### Links

* Effective Nerd Fonts in Multiple Terminals: https://www.youtube.com/watch?v=mQdB_kHyZn8&t=84s
* The (almost) perfect Neovim setup for Node.js: https://www.youtube.com/watch?v=CVCBHHFXWNE
* Mason package repository: https://mason-registry.dev/registry/list
* Multi-file Search and Replace in Neovim: https://levelup.gitconnected.com/multi-file-search-and-replace-in-neovim-83a0a8d22e14#:~:text=Once%20you%20have%20Telescope%20installed,whatever%20you%20are%20searching%20for.&text=Once%20you%20have%20your%20results,in%20Telescope%20is%20Ctrl%2BQ.&text=Hit%20enter%20and%20you%20should,each%20replace%20in%20the%20list.
* How to attach debugger to ts-node command in VSCode: https://stackoverflow.com/questions/73634693/how-to-attach-debugger-to-ts-node-command-in-vscode
* nvim-dap adapter for vscode-js-debug: https://github.com/mxsdev/nvim-dap-vscode-js
* Learn Vim the Smart Way: https://learnvim.irian.to
* react + typescript neovim setup: https://github.com/anasrar/.dotfiles/blob/4c444c3ab2986db6ca7e2a47068222e47fd232e2/neovim/.config/nvim/lua/rin/DAP/languages/typescript.lua

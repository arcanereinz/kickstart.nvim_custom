### Description

Based off of nvim-lua/kickstart.nvim with updates taken from NvChad/NvChad
NOTE: NvChad/NvChad could not be used directly since it uses true colors (24-bit) and macOS terminal only supports 256 (8-bit)

### Instructions

1. To load ./custom/init.lua add the following the end of the init.lua
```lua
require('custom.init');
```

2. To load ./custom/plugins/plugins.lua uncomment the following in init.lua
```lua
{ import = 'custom.plugins' }
```

### Links

Effective Nerd Fonts in Multiple Terminals: https://www.youtube.com/watch?v=mQdB_kHyZn8&t=84s

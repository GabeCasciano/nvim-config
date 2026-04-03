# README

This is my personal editor setup. I use a variety of plugins, but I am trying
to use less. This was my crack at a more minimal setup that what I was
previously used to.

My directory is structured as follows:

```
.
├── init.lua
├── lua
│   ├── config
│   │   ├── autocmds.lua
│   │   ├── lazy.lua
│   │   └── mappings.lua
│   └── plugins
│       ├── clangd_extensions.lua
│       ├── cmp.lua
│       ├── colour-scheme.lua
│       ├── conform.lua
│       ├── lspconfig.lua
│       ├── lua-line.lua
│       ├── markdown-preview.lua
│       ├── mason.lua
│       ├── obsidian.lua
│       ├── oil.lua
│       ├── render-markdown.lua
│       ├── telescope.lua
│       ├── treesitter.lua
│       ├── vimtex.lua
│       └── which-key.lua
└── README.md
```

New plugins are installed as seperate `*.lua` files. The files in `config` are
called directly from `init.lua`, afterwards it calls each plugin in the
`plugin` directory.

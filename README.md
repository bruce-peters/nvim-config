# NVIM CONFIG

This is my personal Neovim configuration, which I use for development. It includes various plugins and settings to enhance the Neovim experience.

## Details

- **Language**: Lua
- **Plugins**: Managed by lazy.nvim

Highlights: gruvbox (transparent background), Snacks.nvim (dashboard, file explorer, pickers, notifications),
Telescope with fzf-native, Treesitter, LSP through mason + nvim-lspconfig, nvim-cmp completion, conform.nvim
format-on-save, nvim-lint, nvim-dap + dap-ui, nvim-jdtls for Java, toggleterm, trouble, which-key,
GitHub Copilot and avante.nvim (Copilot provider).

The config is set up for **Windows** (PowerShell shell, Java and WPILib paths). It also loads on Linux and
macOS, but a few Windows-only parts need editing there (see [Platform notes](#platform-notes)).

## Install

### Requirements

| Tool | Used for |
|---|---|
| **Neovim 0.11+** | required (mason-lspconfig v2 relies on `vim.lsp.enable`) |
| git | lazy.nvim bootstraps itself and clones plugins |
| A C compiler + `make` (Windows: CMake + MSVC build tools) | builds `telescope-fzf-native` |
| `make`, `curl`, `tar` | Treesitter parsers and the avante.nvim prebuilt binary |
| [ripgrep](https://github.com/BurntSushi/ripgrep) (`rg`), optionally `fd` | Snacks grep / file pickers |
| Node.js + npm | GitHub Copilot, and mason installs of `ts_ls`, `html`, `cssls`, `tailwindcss`, `pyright`, `prettier`, `eslint_d`, … |
| Python 3 + pip | mason installs of `black`, `isort`, `pylint` |
| JDK 21 (and JDK 17 for older projects) | `jdtls` (Java LSP) needs Java 21+ |
| PHP + Composer (optional) | `php-cs-fixer` and `phpstan` from mason |
| A [Nerd Font](https://www.nerdfonts.com/) set in your terminal | icons (devicons, lualine, bufferline, diagnostics) |
| A true-color terminal | `termguicolors` is on |

### Steps

Back up any existing config first.

**Linux / macOS**

```bash
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null
mv ~/.local/share/nvim ~/.local/share/nvim.bak 2>/dev/null   # old plugins/state (optional)
git clone https://github.com/bruce-peters/nvim-config.git ~/.config/nvim
nvim
```

**Windows (PowerShell)**

```powershell
Move-Item $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.bak -ErrorAction SilentlyContinue
Move-Item $env:LOCALAPPDATA\nvim-data $env:LOCALAPPDATA\nvim-data.bak -ErrorAction SilentlyContinue
git clone https://github.com/bruce-peters/nvim-config.git $env:LOCALAPPDATA\nvim
nvim
```

On first launch, lazy.nvim installs itself and every plugin at the commits pinned in `lazy-lock.json`.
mason then starts installing the language servers and tools listed in `lua/plugins/lsp/mason.lua`
(watch progress with `:Mason`). Restart Neovim once that finishes, then run `:checkhealth` to see anything
that's missing.

To install headlessly (for example in a script), run:

```bash
nvim --headless "+Lazy! sync" +qa
```

`+Lazy! restore` instead installs exactly the versions in `lazy-lock.json`.

Tested on Ubuntu 24.04 with Neovim 0.11.4: the clone, `Lazy! sync` and `Lazy! restore` work and startup has no
config errors. The Windows commands above were not run here.

To sign in to Copilot (used by both `copilot.vim` and avante.nvim), run `:Copilot setup`.

## Key bindings (leader = `Space`)

| Keys | Action |
|---|---|
| `<leader>ff` / `<leader>fr` / `<leader>/` | find files / recent files / grep (Snacks) |
| `<leader><space>` / `<leader>,` | smart file finder / buffers |
| `<leader>ee` | toggle file explorer |
| `gd` / `gR` / `K` / `<leader>rn` / `<leader>ca` | LSP definition / references / hover / rename / code action |
| `<leader>mp` | format file (conform; also runs on save) |
| `<leader>xw` / `<leader>xd` | Trouble workspace / document diagnostics |
| `<C-\>` / `<leader>tt` | toggle terminal |
| `<leader>rf` | run current file (Python, JS, Java, C, C++, shell) |
| `<leader>bb` / `<leader>dc` | toggle breakpoint / start or continue debugging |
| `<leader>sv` / `<leader>sh` / `<leader>sx` / `<leader>sm` | split vertical / horizontal / close / maximize |
| `<C-s>` | save |

Press `<leader>` and wait for which-key to list the rest.

## Project structure

```
init.lua                 loads core settings, bootstraps lazy.nvim, imports lua/plugins and lua/plugins/lsp
lua/core/options.lua     editor options (and the PowerShell shell on Windows)
lua/core/keymaps.lua     general key bindings
lua/plugins/*.lua        one lazy.nvim spec per plugin
lua/plugins/lsp/         mason (server/tool list) and nvim-lspconfig (LSP keymaps, diagnostics)
ftplugin/java.lua        jdtls startup for Java files
java-formatter.xml       Eclipse formatter profile used by jdtls
lazy-lock.json           pinned plugin commits
```

## Platform notes

- `ftplugin/java.lua` hard-codes Windows paths: mason's jdtls under `~/AppData/Local/nvim-data/mason`, JDKs
  at `C:/Program Files/Java/jdk-17` and `jdk-21`, and `java-formatter.xml` under `~/AppData/Local/nvim`. On
  Linux/macOS, point these at `~/.local/share/nvim/mason/...`, your JDK homes, and `~/.config/nvim`.
- `lua/plugins/toggleterm.lua` uses `shell = "pwsh.exe"` (PowerShell 7), and the `<leader>wp*` WPILib commands
  use `C:/Users/Public/wpilib/2025`. Change both on other systems.
- `lua/core/options.lua` switches Neovim's shell to `pwsh` (or Windows PowerShell if PowerShell 7 isn't
  installed) only on Windows.

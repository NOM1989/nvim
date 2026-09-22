-- dropbar starts disabled; toggled on/off with <Leader>\ (see dropbar.nvim spec below)
local dropbar_enabled = false

return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    opts = require "configs.lspconfig",
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "python",
        "markdown",
        "markdown_inline",
      },
    },
  },

  -- Don't need as:
  -- normal H toggles dotfiles
  -- normal I toggles gitignore
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   opts = { filters = { dotfiles = false } },
  -- },

  -- pretty diagnostics panel
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
    lazy = true,
  },

  -- Persistence for nvim sessions (per workspace)
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    opts = {},
    lazy = true,
  },

  { "nvzone/menu", lazy = true },

  -- {
  --   "supermaven-inc/supermaven-nvim",
  --   lazy = true,
  --   event = "InsertEnter",
  --   config = function()
  --     require("supermaven-nvim").setup {
  --       keymaps = {
  --         accept_suggestion = "<C-Tab>",
  --         clear_suggestion = "<C-]>",
  --         accept_word = "<C-j>",
  --       },
  --     }
  --   end,
  -- },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {

      {
        "hrsh7th/cmp-cmdLine",
        event = "CmdlineEnter",
        config = function()
          local cmp = require "cmp"

          cmp.setup.cmdline("/", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = { { name = "buffer" } },
          })

          cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
              { name = "path" },
            }, {
              {
                name = "cmdline",
                option = {
                  ignore_cmds = { "Man", "!" },
                },
              },
            }),
          })
        end,
      },

      {
        "MeanderingProgrammer/render-markdown.nvim",
        config = function()
          local cmp = require "cmp"

          cmp.setup {
            sources = cmp.config.sources { { name = "render-markdown" } },
          }
        end,
      },
    },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    -- dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },

  -- {
  --   "folke/flash.nvim",
  --   event = "VeryLazy",
  --   ---@type Flash.Config
  --   opts = {},
  --   -- stylua: ignore
  --   keys = {
  --     { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
  --     { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
  --     { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
  --     -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
  --     -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  --   },
  -- },

  -- Disable an NvChad default
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
    enabled = false,
  },

  -- lazy.nvim
  {
    "folke/snacks.nvim",
    lazy = false,
    ---@type snacks.Config
    opts = {
      indent = {
        enabled = true,
        -- chunk = { enabled = true, char = {
        --   corner_top = "╭",
        --   corner_bottom = "╰",
        -- } },
      },
      -- scroll = { enabled = true },
      -- bigfile = { enabled = true },
      lazygit = { enabled = true },
    },
    keys = {
      {
        "<space>l",
        function()
          require("snacks").lazygit.open()
        end,
        desc = "Open Lazygit",
      },
    },
  },

  {
    "kylechui/nvim-surround",
    version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },

  -- {
  --   "eandrju/cellular-automaton.nvim",
  --   event = "VeryLazy",
  -- },

  {
    "sphamba/smear-cursor.nvim",
    lazy = true,
    event = "InsertEnter",
    opts = {
      -- Smear cursor when switching buffers or windows.
      smear_between_buffers = false,

      -- Smear cursor when moving within line or to neighbor lines.
      -- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
      smear_between_neighbor_lines = true,

      -- Draw the smear in buffer space instead of screen space when scrolling
      scroll_buffer_space = true,

      -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
      -- Smears and particles will look a lot less blocky.
      legacy_computing_symbols_support = false,

      -- Smear cursor in insert mode.
      -- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
      smear_insert_mode = false,
      smear_to_cmd = false,

      -- frame rate
      time_interval = 8, -- milliseconds

      filetypes_disabled = { "NvimTree" },

      delay_disable = 150, -- milliseconds

      particles_enabled = true,
      stiffness = 1,
      trailing_stiffness = 1,
      damping = 1,
      gradient_exponent = 0,
      gamma = 2.2,

      max_length = 1,
      max_length_insert_mode = 1,

      never_draw_over_target = true, -- if you want to actually see under the cursor
      hide_target_hack = true, -- same

      particle_spread = 1,
      particles_per_second = 500,
      particles_per_length = 50,
      particle_max_lifetime = 800,
      particle_max_initial_velocity = 20,
      particle_velocity_from_cursor = 0.5,
      particle_damping = 0.15,
      particle_gravity = -50,
      min_distance_emit_particles = 12,
    },
  },

  {
    "ggml-org/llama.vim",
    lazy = false,
    init = function()
      vim.g.llama_config = {
        endpoint_fim = "http://192.168.0.146:8012/infill",

        auto_fim = true,
        show_info = 0, -- 1 = statusline, 2 = inline, 0 = off
        -- Note: 1 stomps NvChad's statusline: llama.vim does `set statusline=` to clear its own text, which resets to Neovim's builtin default instead of restoring the previous value

        -- context tuning
        n_prefix = 256,
        n_suffix = 64,
        n_predict = 128,
        ring_n_chunks = 16, -- cross-file chunks; raise on a fast model
        ring_chunk_size = 64,
        ring_scope = 1024,
        ring_update_ms = 1000,

        keymap_fim_trigger = "<C-f>",
        keymap_fim_accept_full = "<C-l>",
        keymap_fim_accept_line = "<C-Tab>",
        keymap_fim_accept_word = "<C-k>",
      }
    end,
  },

  {
    "Bekaboo/dropbar.nvim",
    lazy = true,
    -- no event/cmd/ft trigger: only loads when one of the keys below is pressed
    -- optional, but required for fuzzy finder support
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    keys = {
      {
        "<Leader>\\",
        function()
          dropbar_enabled = not dropbar_enabled
          local dropbar_utils = require "dropbar.utils"
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            local buf = vim.api.nvim_win_get_buf(win)
            if dropbar_enabled then
              dropbar_utils.bar.attach(buf, win)
            else
              vim.wo[win][0].winbar = ""
            end
          end
        end,
        desc = "Toggle dropbar",
      },
      {
        "<Leader>;",
        function()
          require("dropbar.api").pick()
        end,
        desc = "Pick symbols in winbar",
      },
      {
        "[;",
        function()
          require("dropbar.api").goto_context_start()
        end,
        desc = "Go to start of current context",
      },
      {
        "];",
        function()
          require("dropbar.api").select_next_context()
        end,
        desc = "Select next context",
      },
    },
    opts = {
      bar = {
        sources = function(buf, _)
          local sources = require "dropbar.sources"
          local utils = require "dropbar.utils"
          if vim.bo[buf].ft == "markdown" then
            return {
              sources.markdown,
            }
          end
          if vim.bo[buf].buftype == "terminal" then
            return {
              sources.terminal,
            }
          end
          return {
            utils.source.fallback {
              sources.lsp,
              sources.treesitter,
            },
          }
        end,
      },
    },
    config = function(_, opts)
      -- wrap the default `enable` check with the toggleable flag, so staying
      -- disabled also stops dropbar re-attaching itself on future buffer/window events
      local default_enable = require("dropbar.configs").opts.bar.enable
      opts.bar.enable = function(buf, win, info)
        return dropbar_enabled and default_enable(buf, win, info)
      end
      require("dropbar").setup(opts)
    end,
  },
}

return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  'marko-cerovac/material.nvim',
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    opts = {
      ignore_lsp = { "lua_ls" },
      detection_methods = { "pattern", "lsp" },
      exclude_dirs = { ".cargo" },
      patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "Cargo.toml" },
    },
    config = function(_, opts) require("project_nvim").setup(opts) end,
  },
  { "nvim-telescope/telescope.nvim", opts = function() require("telescope").load_extension "projects" end },
  {
    "vim-test/vim-test",
    event = "VeryLazy",
  },
  {
	  "robitx/gp.nvim",
    event = "VeryLazy",
	  config = function()

      local conf = {
	      -- required openai api key
	      openai_api_key = os.getenv("OPENAI_API_KEY"),
	      -- prefix for all commands
	      cmd_prefix = "Gp",

	      -- directory for storing chat files
	      chat_dir = vim.fn.stdpath("data"):gsub("/$", "") .. "/gp/chats",
	      -- chat model (string with model name or table with model name and parameters)
	      chat_model = { model = "gpt-3.5-turbo-16k", temperature = 0.7, top_p = 1 },
	      -- chat model system prompt
	      chat_system_prompt = "You are a general AI assistant.",
	      -- chat user prompt prefix
	      chat_user_prefix = "🗨:",
	      -- chat assistant prompt prefix
	      chat_assistant_prefix = "🤖:",
	      -- chat topic generation prompt
	      chat_topic_gen_prompt = "Summarize the topic of our conversation above"
		      .. " in two or three words. Respond only with those words.",
	      -- chat topic model (string with model name or table with model name and parameters)
	      chat_topic_gen_model = "gpt-3.5-turbo-16k",
	      -- explicitly confirm deletion of a chat file
	      chat_confirm_delete = true,
	      -- conceal model parameters in chat
	      chat_conceal_model_params = true,
	      -- local shortcuts bound to the chat buffer
	      -- (be careful to choose something which will work across specified modes)
	      chat_shortcut_respond = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g><C-g>" },
	      chat_shortcut_delete = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>d" },
	      chat_shortcut_new = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>n" },

	      -- command config and templates bellow are used by commands like GpRewrite, GpEnew, etc.
	      -- command prompt prefix for asking user for input
	      command_prompt_prefix = "🤖 ~ ",
	      -- command model (string with model name or table with model name and parameters)
	      command_model = { model = "gpt-3.5-turbo-16k", temperature = 0.7, top_p = 1 },
	      -- command system prompt
	      command_system_prompt = "You are an AI that strictly generates just the formated final code.",

	      -- templates
	      template_selection = "I have the following code from {{filename}}:"
		      .. "\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}",
	      template_rewrite = "I have the following code from {{filename}}:"
		      .. "\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}"
		      .. "\n\nRespond just with the snippet of code that should be inserted.",
	      template_command = "{{command}}",

	      -- example hook functions (see Extend functionality section in the README)
	      hooks = {
		      InspectPlugin = function(plugin, params)
			      print(string.format("Plugin structure:\n%s", vim.inspect(plugin)))
			      print(string.format("Command params:\n%s", vim.inspect(params)))
		      end,

		      -- GpImplement finishes the provided selection/range based on comments in the code
		      Implement = function(gp, params)
			      local template = "I have the following code from {{filename}}:\n\n"
				    .. "```{{filetype}}\n{{selection}}\n```\n\n"
				    .. "Please finish the code above according to comment instructions."
				    .. "\n\nRespond just with the snippet of code that should be inserted."

			      gp.Prompt(
				      params,
				      gp.Target.rewrite,
				      nil, -- command will run directly without any prompting for user input
				      gp.config.command_model,
				      template,
				      gp.config.command_system_prompt
			      )
		      end,

		      -- your own functions can go here, see README for more examples like
		      -- :GpExplain, :GpUnitTests.., :GpBetterChatNew, ..
		      --
          UnitTests = function(gp, params)
            local template = "I have the following code from {{filename}}:\n\n"
            .. "```{{filetype}}\n{{selection}}\n```\n\n"
            .. "Please respond by writing table driven unit tests for the code above."
            gp.Prompt(params, gp.Target.enew, nil, gp.config.command_model,
              template, gp.config.command_system_prompt)
          end,

          -- example of adding command which explains the selected code
          Explain = function(gp, params)
            local template = "I have the following code from {{filename}}:\n\n"
            .. "```{{filetype}}\n{{selection}}\n```\n\n"
            .. "Please respond by explaining the code above."
            gp.Prompt(params, gp.Target.popup, nil, gp.config.command_model,
              template, gp.config.chat_system_prompt)
          end,
          -- example of adding command which explains the selected code
          RewriteComment = function(gp, params)
            local template = "I have the following comment from {{filename}}:\n\n"
            .. "```{{filetype}}\n{{selection}}\n```\n\n"
            .. "Please respond by fixing the grammar of the comment and use academic english. Respond only a valid comment as used in the {{filetype}} language."
            gp.Prompt(params, gp.Target.rewrite, nil, gp.config.command_model,
              template, gp.config.chat_system_prompt)
          end,

	      },
      }

      -- call setup on your config
      require("gp").setup(conf)

	  end,
  },
  {
    "Bryley/neoai.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    cmd = {
      "NeoAI",
      "NeoAIOpen",
      "NeoAIClose",
      "NeoAIToggle",
      "NeoAIContext",
      "NeoAIContextOpen",
      "NeoAIContextClose",
      "NeoAIInject",
      "NeoAIInjectCode",
      "NeoAIInjectContext",
      "NeoAIInjectContextCode",
    },
    keys = {
      { "<leader>As", desc = "summarize text" },
      { "<leader>Ag", desc = "generate git message" },
    },
    config = function()
      -- https://github.com/Bryley/neoai.nvim#setup
      require("neoai").setup({
        -- Options go here
      })
    end,
  }
}

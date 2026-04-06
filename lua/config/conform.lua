local M = {}

local function find_upward(path, markers)
	return vim.fs.find(markers, {
		upward = true,
		path = path,
	})[1]
end

local function php_formatters(bufnr)
	local filename = vim.api.nvim_buf_get_name(bufnr)
	local dirname = vim.fs.dirname(filename)
	local conform = require("conform")

	if dirname and find_upward(dirname, { "artisan" }) then
		return { "pint" }
	end

	if dirname and find_upward(dirname, {
		"config/config.inc.php",
		"config/defines.inc.php",
		"app/config/parameters.php",
	}) then
		return { "php_cs_fixer" }
	end

	if conform.get_formatter_info("pint", bufnr).available then
		return { "pint" }
	end

	if conform.get_formatter_info("php_cs_fixer", bufnr).available then
		return { "php_cs_fixer" }
	end

	return {}
end

function M.setup()
	require("conform").setup({
		formatters = {
			pint = {
				command = function(ctx)
					local local_pint = vim.fs.find("vendor/bin/pint", {
						upward = true,
						path = ctx.dirname,
					})[1]

					if local_pint then
						return local_pint
					end

					return "pint"
				end,
				args = { "$FILENAME" },
				stdin = false,
			},
			php_cs_fixer = {
				command = function(ctx)
					local local_php_cs_fixer = vim.fs.find("vendor/bin/php-cs-fixer", {
						upward = true,
						path = ctx.dirname,
					})[1]

					if local_php_cs_fixer then
						return local_php_cs_fixer
					end

					return "php-cs-fixer"
				end,
				args = { "fix", "$FILENAME" },
				stdin = false,
			},
		},

		formatters_by_ft = {
			lua = { "stylua" },

			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			vue = { "prettier" },

			css = { "prettier" },
			scss = { "prettier" },
			html = { "prettier" },
			json = { "prettier" },
			yaml = { "prettier" },
			markdown = { "prettier" },

			php = php_formatters,
		},

		default_format_opts = {
			lsp_format = "fallback",
		},

		format_on_save = {
			timeout_ms = 1000,
		},
	})
end

return M

return {
	cmd = { "tailwindcss-language-server", "--stdio" },
	filetypes = {
		"html",
		"css",
		"scss",
		"javascript",
		"javascriptreact",
		"smarty",
		"typescript",
		"typescriptreact",
		"twig",
		"vue",
		"blade",
	},
	root_dir = require("config.lsp.tailwind_root"),
}

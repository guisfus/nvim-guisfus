local prestashop_root = require("config.lsp.prestashop_root")

return function(bufnr, on_dir)
	local root = vim.fs.root(bufnr, { "composer.json", "artisan" })
	if root then
		on_dir(root)
		return
	end

	root = prestashop_root.find_root(bufnr)
	if root then
		on_dir(root)
		return
	end

	root = vim.fs.root(bufnr, { ".git" })
	if root then
		on_dir(root)
	end
end

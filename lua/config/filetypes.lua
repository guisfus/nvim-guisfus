vim.filetype.add({
	extension = {
		tpl = "smarty",
		twig = "twig",
	},
	pattern = {
		[".*%.blade%.php"] = "blade",
	},
})

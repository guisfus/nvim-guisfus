return {
	cmd = { "intelephense", "--stdio" },
	filetypes = { "php" },
	root_markers = {
		"composer.json",
		"artisan",
		"config/config.inc.php",
		"config/defines.inc.php",
		"app/config/parameters.php",
		".git",
	},
	settings = {
		intelephense = {
			telemetry = {
				enabled = false,
			},
		},
	},
}

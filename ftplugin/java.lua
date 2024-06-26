local jdtls_ok, _ = pcall(require, "jdtls")
if not jdtls_ok then
	vim.notify "JDTLS not found, install with `:MasonInstall jdtls`"
	return
end

local jdtls_dir = vim.fn.stdpath('data') .. '/mason/packages/jdtls'
local config_dir = jdtls_dir .. '/config_linux'
local plugins_dir = jdtls_dir .. '/plugins'
local path_to_jar = plugins_dir .. '/org.eclipse.equinox.launcher_1.6.800.v20240304-1850.jar'
local lombok_path = jdtls_dir .. "/lombok.jar"

local root_markers = { "pom.xml", ".git", "mvnw", "gradlew", "build.gradle" }
local root_dir = require('jdtls.setup').find_root(root_markers)

if root_dir == "" then
	vim.notify('Java LSP - JDTLS - No project root found!', vim.log.levels.WARN)
	return
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath('data') .. '/site/java/workspace-root/' .. project_name
os.execute("mkdir " .. workspace_dir)

local config = {
	cmd = {
		'java',
		'-Declipse.application=org.eclipse.jdt.ls.core.id1',
		'-Dosgi.bundles.defaultStartLevel=4',
		'-Declipse.product=org.eclipse.jdt.ls.core.product',
		'-Dlog.protocol=true',
		'-Dlog.level=ALL',
		'-javaagent:' .. lombok_path,
		'-Xmx1g',
		'--add-modules=ALL-SYSTEM',
		'--add-opens', 'java.base/java.util=ALL-UNNAMED',
		'--add-opens', 'java.base/java.lang=ALL-UNNAMED',

		'-jar', path_to_jar,
		'-configuration', config_dir,
		'-data', workspace_dir,
	},

	root_dir = root_dir,

	settings = {
		java = {
			home = '/usr/lib/jvm/java-17-openjdk',
			eclipse = { downloadSources = true },
			configuration = {
				updateBuildConfiguration = 'interactive',
				runtimes = {
					{ name = "JavaSE-17", path = '/usr/lib/jvm/java-17-openjdk' },
				},
			},
			maven = { downloadSources = true },
			implementationsCodeLens = { enabled = true },
			referencesCodeLens = { enabled = true },
			references = { includeDecompiledSources = true },
			format = {
				enabled = true,
				settings = {
					url = vim.fn.stdpath('config') .. '/lang-servers/intellij-java-google-style.xml',
					profile = 'GoogleStyle',
				},
			},
		},
		signatureHelp = { enabled = true },
		completion = {
			favoriteStaticMembers = {
				"org.hamcrest.MatcherAssert.assertThat",
				"org.hamcrest.Matchers.*",
				"org.hamcrest.CoreMatchers.*",
				"org.junit.jupiter.api.Assertions.*",
				"java.util.Objects.requireNonNull",
				"java.util.Objects.requireNonNullElse",
				"org.mockito.Mockito.*",
			},
			importOrder = { "java", "javax", "com", "org" },
		},
		sources = {
			organizeImports = {
				starThreshold = 9999,
				staticStarThreshold = 9999,
			},
		},
		codeGeneraion = {
			toString = {
				template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
			},
			useBlocks = true,
		},
		flags = { allow_incremental_sync = true },
		init_options = { bundles = {} },
	},
}

config['on_attach'] = require 'configs.mason-lspconfig'.on_attach

require('jdtls').start_or_attach(config)

local home = os.getenv('HOME')
local jdtls = require('jdtls')

local nvim_home = vim.fn.stdpath('data')
local jdtls_path = nvim_home .. "/mason/packages/jdtls"
local path_to_config = jdtls_path .. "/config_mac"
local path_to_plugins = jdtls_path .. "/plugins"
local path_to_jar_jdtls = path_to_plugins .. "/org.eclipse.equinox.launcher_*.jar"
local path_to_lombok = jdtls_path .. "/lombok.jar"


local root_markers = {'gradlew', 'mvnw', '.git'}
local root_dir = require('jdtls.setup').find_root(root_markers)
local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

local on_attach = function(client, bufnr)
    require'eojysele.keymaps'.java_key_map(bufnr);
    require('jdtls').setup_dap({ hotcodereplace = 'auto' })
end

local bundles = {
    vim.fn.glob(home ..'/Code/Instruments/Nvim/Java/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar'),
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local config = {
    flags = {
            debounce_text_changes = 80,
        },

        capabilities = capabilities,
        on_attach = on_attach,

        init_options = {
            bundles = bundles
        },

        root_dir = root_dir,
        settings = {
            java = {
                eclipse = {
                    downloadSources = true,
                },
                maven = {
                    downloadSources = true,
                },
                implementationsCodeLens = {
                    enabled = true,
                },
                referencesCodeLens = {
                    enabled = true,
                },
                references = {
                    includeDecompiledSources = true,
                },
                format = {
                    settings = {
                        url = home .. "/.config/nvim/code-styles/intellij-java-google-style.xml",
                        profile = "GoogleStyle",
                    },
                },
                signatureHelp = {
                    enabled = true
                },
                contentProvider = {
                    preferred = 'fernflower'
                },
                completion = {
                    favoriteStaticMembers = {
                        "org.hamcrest.MatcherAssert.assertThat",
                        "org.hamcrest.Matchers.*",
                        "org.hamcrest.CoreMatchers.*",
                        "org.junit.jupiter.api.Assertions.*",
                        "java.util.Objects.requireNonNull",
                        "java.util.Objects.requireNonNullElse",
                        "org.mockito.Mockito.*"
                    },
                    importOrder = {
                        "java",
                        "javax",
                        "com",
                        "org"
                    },
                },
            sources = {
                organizeImports = {
                    starThreshold = 9999;
                    staticStarThreshold = 9999;
                },
            },
            codeGeneration = {
                toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
                },
                hashCodeEquals = {
                    useJava7Objects = true,
                },
                useBlocks = true,
            },
            configuration = {
                runtimes = {
                    {
                        name = "JavaSE-17",
                        path = "/Library/Java/JavaVirtualMachines/openjdk-17.jdk/Contents/Home"
                    },
                    {
                        name = "JavaSE-11",
                        path = "/Library/Java/JavaVirtualMachines/openjdk-11.jdk/Contents/Home"
                    }
                }
            }
        }
    },
    cmd = {
        '/Library/Java/JavaVirtualMachines/openjdk.jdk/Contents/Home/bin/java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx4g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-javaagent:' .. path_to_lombok,
        '-jar', vim.fn.glob(path_to_jar_jdtls),
        '-configuration', path_to_config,
        '-data', workspace_folder,
    },
}

jdtls.start_or_attach(config)

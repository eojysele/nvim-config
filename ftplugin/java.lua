local home = os.getenv('HOME')
local jdtls = require('jdtls')

local root_markers = {'gradlew', 'mvnw', '.git'}
local root_dir = require('jdtls.setup').find_root(root_markers)

local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

function nnoremap(rhs, lhs, bufopts, desc)
    bufopts.desc = desc
    vim.keymap.set("n", rhs, lhs, bufopts)
end

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
                format = {
                    settings = {
                        url = home .. "/.config/nvim/code-styles/intellij-java-google-style.xml",
                        profile = "GoogleStyle",
                    },
                },
                signatureHelp = { enabled = true },
                contentProvider = { preferred = 'fernflower' },
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
                    filteredTypes = {
                        "com.sun.*",
                        "io.micrometer.shaded.*",
                        "java.awt.*",
                        "jdk.*", "sun.*",
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
        '-javaagent:' .. home .. '/.local/share/nvim/mason/packages/jdtls/lombok.jar',
        '-jar', vim.fn.glob(home .. '/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
        '-configuration', home .. '/.local/share/nvim/mason/packages/jdtls/config_mac',
        '-data', workspace_folder,
    },
}

jdtls.start_or_attach(config)


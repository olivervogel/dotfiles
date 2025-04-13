return {
   "neovim/nvim-lspconfig",
   version = "^2.0",
   event = { "BufReadPre", "BufNewFile" },
   keys = {
      { "<leader>d", "<cmd>lua vim.diagnostic.open_float()<cr>", noremap = true, silent = true },
      { "<leader>s", "<cmd>lua vim.diagnostic.goto_prev()<CR>", noremap = true, silent = true },
      { "<leader>f", "<cmd>lua vim.diagnostic.goto_next()<CR>", noremap = true, silent = true },
      { "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", noremap = true, silent = true },
   },
   init = function()
      vim.opt.updatetime = 1000

      -- lsp diagnostic config
      vim.diagnostic.config({
         severity_sort = true,
         signs = {
            -- severity = 1
         },
         underline = false,
         virtual_text = false
      })

      -- load capabilities from lsp
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- set shortcuts for lsp commands
      local opts = { noremap=true, silent=true }
      local on_attach = function(client, bufnr)
         vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
         vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
         vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
         vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
         vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>I', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
         vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>i', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
         vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', opts)
         vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
         vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
         vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>r', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
      end

      -- intelephense lsp
      require('lspconfig').intelephense.setup {
         capabilities = capabilities,
         on_attach = on_attach,
         settings = {
            intelephense = {
               stubs = {
                  "ast",
                  "bcmath",
                  "bz2",
                  "calendar",
                  "Core",
                  "crypto",
                  "ctype",
                  "curl",
                  "date",
                  "dba",
                  "decimal",
                  "dio",
                  "dom",
                  "ds",
                  "eio",
                  "enchant",
                  "Ev",
                  "event",
                  "exif",
                  "expect",
                  "fann",
                  "FFI",
                  "ffmpeg",
                  "fileinfo",
                  "filter",
                  "fpm",
                  "ftp",
                  "gd",
                  "gearman",
                  "geoip",
                  "geos",
                  "gettext",
                  "gmagick",
                  "gmp",
                  "gnupg",
                  "grpc",
                  "hash",
                  "http",
                  "ibm_db2",
                  "iconv",
                  "igbinary",
                  "imagick",
                  "imap",
                  "inotify",
                  "interbase",
                  "intl",
                  "json",
                  "judy",
                  "ldap",
                  "leveldb",
                  "libevent",
                  "libsodium",
                  "libvirt-php",
                  "libxml",
                  "lua",
                  "LuaSandbox",
                  "lzf",
                  "mailparse",
                  "mapscript",
                  "mbstring",
                  "mcrypt",
                  "memcache",
                  "memcached",
                  "meminfo",
                  "meta",
                  "ming",
                  "mongo",
                  "mongodb",
                  "mosquitto-php",
                  "mqseries",
                  "msgpack",
                  "mssql",
                  "mysql",
                  "mysql_xdevapi",
                  "mysqli",
                  "ncurses",
                  "newrelic",
                  "oauth",
                  "oci8",
                  "odbc",
                  "openssl",
                  "parallel",
                  "Parle",
                  "pcntl",
                  "pcov",
                  "pcre",
                  "pdflib",
                  "PDO",
                  "pdo_ibm",
                  "pdo_mysql",
                  "pdo_pgsql",
                  "pdo_sqlite",
                  "pgsql",
                  "Phar",
                  "phpdbg",
                  "posix",
                  "pq",
                  "pspell",
                  "pthreads",
                  "radius",
                  "random",
                  "rar",
                  "rdkafka",
                  "readline",
                  "recode",
                  "redis",
                  "Reflection",
                  "regex",
                  "rpminfo",
                  "rrd",
                  "SaxonC",
                  "session",
                  "shmop",
                  "simple_kafka_client",
                  "SimpleXML",
                  "snappy",
                  "snmp",
                  "soap",
                  "sockets",
                  "sodium",
                  "solr",
                  "SPL",
                  "SplType",
                  "SQLite",
                  "sqlite3",
                  "sqlsrv",
                  "ssh2",
                  "standard",
                  "stats",
                  "stomp",
                  "suhosin",
                  "superglobals",
                  "svm",
                  "svn",
                  "swoole",
                  "sybase",
                  "sync",
                  "sysvmsg",
                  "sysvsem",
                  "sysvshm",
                  "tidy",
                  "tokenizer",
                  "uopz",
                  "uploadprogress",
                  "uuid",
                  "uv",
                  "v8js",
                  "wddx",
                  "win32service",
                  "winbinder",
                  "wincache",
                  "wordpress",
                  "xcache",
                  "xdebug",
                  "xdiff",
                  "xhprof",
                  "xlswriter",
                  "xml",
                  "xmlreader",
                  "xmlrpc",
                  "xmlwriter",
                  "xsl",
                  "xxtea",
                  "yaf",
                  "yaml",
                  "yar",
                  "zend",
                  "Zend OPcache",
                  "ZendCache",
                  "ZendDebugger",
                  "ZendUtils",
                  "zip",
                  "zlib",
                  "zmq",
                  "zookeeper",
                  "zstd"
               }
            }
         }
      }

      -- html language server
      require('lspconfig').html.setup {
         on_attach = on_attach,
         capabilities = capabilities,
         cmd = { "vscode-html-language-server", "--stdio" },
         filetypes = { "html", "silverstripe_html", "blade" },
         init_options = {
            configurationSection = { "html", "css", "javascript" },
            embeddedLanguages = {
               css = true,
               javascript = true
            },
            provideFormatter = true
         },
      }

      -- css language server
      require('lspconfig').cssls.setup {
         on_attach = on_attach,
         capabilities = capabilities,
         cmd = { "vscode-css-language-server", "--stdio" },
         filetypes = { "css", "less", "scss" },
      }

      -- javascript/typescript language server
      require('lspconfig').eslint.setup {
         on_attach = on_attach,
         capabilities = capabilities,
         cmd = { "vscode-eslint-language-server", "--stdio" },
      }

      -- show diagnostic warning with line highlighting instead of symbol
      vim.api.nvim_set_hl(0, "DiagnosticLineNrError", { bg = "#51202A", fg = "#FF0000", bold = true })
      vim.api.nvim_set_hl(0, "DiagnosticLineNrWarn",  { bg = "#51412A", fg = "#FFA500", bold = true })
      vim.api.nvim_set_hl(0, "DiagnosticLineNrInfo",  { bg = "#1E535D", fg = "#00FFFF", bold = true })
      vim.api.nvim_set_hl(0, "DiagnosticLineNrHint",  { bg = "#1E205D", fg = "#0000FF", bold = true })

      -- show diagnostic warning with line highlighting instead of symbol
      vim.diagnostic.config({
         signs = {
            text = {
               [vim.diagnostic.severity.ERROR] = "",
               [vim.diagnostic.severity.WARN] = "",
               [vim.diagnostic.severity.INFO] = "",
               [vim.diagnostic.severity.HINT] = "",
            },
            numhl = {
               [vim.diagnostic.severity.ERROR] = "DiagnosticLineNrError",
               [vim.diagnostic.severity.WARN] = "DiagnosticLineNrWarn",
               [vim.diagnostic.severity.HINT] = "DiagnosticLineNrHint",
               [vim.diagnostic.severity.INFO] = "DiagnosticLineNrInfo",
            },
         },
      })
   end
}

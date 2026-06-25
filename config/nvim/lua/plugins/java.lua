-- Java tuning layered on top of LazyVim's `lang.java` extra.
--
-- Debugging + test running are enabled separately via the `dap.core` and
-- `test.core` extras in `lazyvim.json` (that's what installs java-debug-adapter
-- and java-test and wires up nvim-dap + neotest-java).
local uv = vim.uv or vim.loop

return {
  -- Spring Boot language server. Provides application.yml/.properties completion,
  -- bean navigation, and other Spring-aware features. Its jdtls bundles are
  -- injected into jdtls below via `opts.jdtls`.
  {
    "JavaHello/spring-boot.nvim",
    ft = "java",
    dependencies = { "mfussenegger/nvim-jdtls" },
    config = function()
      require("spring_boot").setup({})
    end,
  },

  {
    "mfussenegger/nvim-jdtls",
    dependencies = { "JavaHello/spring-boot.nvim" },
    opts = function(_, opts)
      -- Lombok: enable the agent that ships inside Mason's jdtls package so
      -- generated getters/setters/builders resolve instead of erroring.
      local lombok = vim.fn.stdpath("data") .. "/mason/packages/jdtls/lombok.jar"
      opts.cmd = opts.cmd or { vim.fn.exepath("jdtls") }
      if uv.fs_stat(lombok) then
        table.insert(opts.cmd, "--jvm-arg=-javaagent:" .. lombok)
      end

      -- Inject the Spring Boot LSP bundles into jdtls' init_options. Using the
      -- `opts.jdtls` override hook keeps the dap/test bundles LazyVim already
      -- assembled and appends ours on top.
      opts.jdtls = function(config)
        config.init_options = config.init_options or {}
        config.init_options.bundles = config.init_options.bundles or {}
        local ok, spring_boot = pcall(require, "spring_boot")
        if ok then
          vim.list_extend(config.init_options.bundles, spring_boot.java_extensions())
        end
        return config
      end

      -- jdtls settings deltas, deep-merged onto LazyVim's defaults.
      opts.settings = vim.tbl_deep_extend("force", opts.settings or {}, {
        java = {
          -- Register every JDK on this machine so jdtls can validate/run
          -- projects against the runtime matching their source level.
          configuration = {
            runtimes = {
              { name = "JavaSE-17", path = "/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home" },
              -- mise install path is version-pinned; update if you bump Corretto.
              { name = "JavaSE-21", path = "/Users/jeff.wiemold/.local/share/mise/installs/java/corretto-21.0.6.7.1" },
              { name = "JavaSE-25", path = "/Library/Java/JavaVirtualMachines/temurin-25.jdk/Contents/Home" },
            },
          },
          -- Static members offered as auto-import completions (test-heavy code).
          completion = {
            favoriteStaticMembers = {
              "org.junit.jupiter.api.Assertions.*",
              "org.mockito.Mockito.*",
              "org.hamcrest.MatcherAssert.assertThat",
              "org.hamcrest.Matchers.*",
              "org.hamcrest.CoreMatchers.*",
              "java.util.Objects.requireNonNull",
              "java.util.Objects.requireNonNullElse",
            },
          },
          -- Keep imports explicit instead of collapsing into wildcard imports.
          sources = {
            organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 },
          },
          -- Pull real library sources so go-to-definition lands on source, not
          -- decompiled stubs (fernflower is the fallback when sources are absent).
          eclipse = { downloadSources = true },
          maven = { downloadSources = true },
          references = { includeDecompiledSources = true },
          contentProvider = { preferred = "fernflower" },
          -- Richer signature help and reference/implementation lenses.
          signatureHelp = { enabled = true, description = { enabled = true } },
          referencesCodeLens = { enabled = true },
          implementationsCodeLens = { enabled = true },
        },
      })
    end,
  },
}

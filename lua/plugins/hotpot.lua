return {
  "rktjmp/hotpot.nvim",
  -- I *think* this fits better in init than config as we always want to run it.
  init = function (plugin)
    -- note we must require hotpot itself to trigger its self-compile bootstrap.
    -- calling require("hotpot.api.make") wont work yet as the files dont exist.
    local hotpot = require("hotpot")
    hotpot.setup({
      provide_require_fennel = true
    })
    -- hotpot lazy-proxies submodules anyway so we can grab make off it...
    local make = hotpot.api.make
    -- path we want to search for plugin-configs
    local conf_path = vim.fn.stdpath("config") .. "/fnl/plugins"
    make.build(conf_path,
      {
        verbosity = 0, -- dont tell me it compiled
        atomic = false -- plugin configs are generally unrelated, so one
                       -- failing to compile should not stop others.
      },
      -- our match is simplistic in this case, just
      -- ~/user/.config/nvim/fnl/plugins/.../x.fnl
      -- ^ root ^^^^^^^^^^^^     ^ path ^^^^^^^^^^
      "(.*)/fnl/(.*)", function (root, path, util)
        -- only need to swap fnl dir for lua
        return util["join-path"](root, "lua", path)
      end)
  end
}

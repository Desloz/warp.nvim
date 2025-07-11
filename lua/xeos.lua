local M = {
}


M.setup = function(opts)
  if opts.warp.enabled then
    local warp = require("warp")

    warp.setup(opts.warp)
    M.warp = warp
  end
end

return M
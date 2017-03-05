hyper = {"cmd", "alt", "ctrl"}

hs.hotkey.bind(hyper, "R", function()
  hs.reload()
end)

hs.hotkey.bind(hyper, "C", function()
  hs.toggleConsole()
end)

require("position")
require("highlight/highlight")

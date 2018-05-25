hyper = {"cmd", "alt", "ctrl"}
hyper2 = {"cmd", "alt"}

function notify(title, informativeText)
  attrs = {
    title = title,
    informativeText = informativeText,
    autoWithdraw = true
  }
  n = hs.notify.new(attrs)
  n:send()
end

hs.hotkey.bind(hyper, "R", function()
  hs.reload()
  notify("Configuration", "Reloaded")
end)

hs.hotkey.bind(hyper, "C", function()
  hs.toggleConsole()
  notify("Console", "Toggle")
end)

require("position")
require("highlight/highlight")

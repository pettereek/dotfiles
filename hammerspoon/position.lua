-- Move to left half
hs.hotkey.bind(hyper, "Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

-- Move to right half
hs.hotkey.bind(hyper, "Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

-- Down
hs.hotkey.bind(hyper, "J", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.y = math.min(f.y + 100, max.h - f.h)
  win:setFrame(f)
end)

-- Up
hs.hotkey.bind(hyper, "K", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.y = math.max(f.y - 100, 0)
  win:setFrame(f)
end)

-- Right
hs.hotkey.bind(hyper, "L", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = math.min(f.x + 100, max.w - f.w)
  win:setFrame(f)
end)

-- Left
hs.hotkey.bind(hyper, "H", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = math.max(f.x - 100, 0)
  win:setFrame(f)
end)

---- Bigger
--hs.hotkey.bind(hyper2, "Up", function()
--  local win = hs.window.focusedWindow()
--  local f = win:frame()
--  local screen = win:screen()
--  local max = screen:frame()

--  f.x = f.x - 50
--  f.y = f.y - 50
--  f.w = math.min(f.w + 100, max.w)
--  f.h = math.min(f.h + 100, max.h)
--  win:setFrame(f)
--end)

---- Smaller
--hs.hotkey.bind(hyper2, "Down", function()
--  local win = hs.window.focusedWindow()
--  local f = win:frame()
--  local screen = win:screen()
--  local max = screen:frame()

--  f.x = f.x + 50
--  f.y = f.y + 50
--  f.w = math.max(f.w - 100, 240)
--  f.h = math.max(f.h - 100, 240)
--  win:setFrame(f)
--end)

-- Full screen
hs.hotkey.bind(hyper, "F", function()
  local win = hs.window.focusedWindow()
  win:setFrame(win:screen():frame())
end)

-- Half screen size
hs.hotkey.bind(hyper, "N", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.w = math.min(1280, max.w)
  f.h = math.min(960, max.h)
  win:setFrame(f)
end)

-- Center screen
hs.hotkey.bind(hyper, "M", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.w / 2 - f.w / 2
  f.y = max.h / 2 - f.h / 2
  win:setFrame(f)
end)

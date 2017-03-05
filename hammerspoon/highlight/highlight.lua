-- Highlights the text in pasteboard
local log = hs.logger.new('highlight','debug')

local executeAppleScript = function(file)
  local path = hs.configdir .. '/highlight/' .. file
  local code, _status = hs.execute('cat ' .. path)
  local _success, result, _code = hs.osascript.applescript(code)

  return result
end

hs.hotkey.bind(hyper, "H", function()
  local pb = hs.pasteboard.readString()

  if pb == nil then
    log.w('Empty pasteboard')
    return
  end

  -- Write contents to tmp file for easier use of highlighter
  file = assert(io.open(os.getenv("HOME")..'/.highlight.tmp', 'w'))
  file:write(pb)

  local syntax = executeAppleScript('syntax.AppleScript')
  if syntax == false then
    log.w('Aborted...')
  end

  local style = executeAppleScript('style.AppleScript')
  if style == false then
    log.w('Aborted...')
  end

  log.i('syntax "' .. syntax .. '", style "', style .. '"')

  local cmd = '/usr/local/bin/highlight -i ~/.highlight.tmp -O rtf --line-numbers --replace-tabs=2 --font-size=32 --font=Monaco --no-trailing-nl --syntax=' .. syntax .. ' --style=' .. style
  local highlighted, _status, _type, _rc = hs.execute(cmd, false)

  local styledText = hs.styledtext.getStyledTextFromData(highlighted, 'rtf')
  hs.pasteboard.writeObjects(styledText)
end)

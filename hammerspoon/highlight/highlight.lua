-- Highlights the text in pasteboard

local log = hs.logger.new('highlight','debug')

local executeAppleScript = function(file)
  local code, _status = hs.execute('cat ' .. hs.configdir .. '/highlight/' .. file)
  local _success, result, _code = hs.osascript.applescript(code)

  if result == 'false' then
    return
  end

  return result
end

-- Get the absolute path for an exetuable named `name`
local absPathExecutable = function(name)
  -- Use `hs.execute(str, __true__)` to load the users $PATH correctly
  local result, status = hs.execute('command -v ' .. name, true)
  local executable = hs.fnutils.split(result, '%s', 2)[1]

  if status == nil or executable == '' then
    return ''
  end

  return executable
end

-- Prints an abort message with `reason`
local abort = function(reason)
  log.w(reason .. ', aborting...')
end

hs.hotkey.bind(hyper, 'H', function()
  local tmpFile = os.getenv('HOME')..'/.highlight.tmp'

  local hl = 'highlight'
  local executable = absPathExecutable(hl)
  if executable == '' then
    hs.notify.show('Highlighting failed 😔', '', 'Try "brew install highlight"')
    return abort('Executable "' .. hl .. '" not found')
  end

  local pb = hs.pasteboard.readString()
  if pb == nil then
    return abort('Empty pasteboard')
  end

  -- Write contents to tmp file, much easier for highlight to handle
  file = assert(io.open(tmpFile, 'w'))
  file:write(pb)

  local syntax = executeAppleScript('syntax.AppleScript')
  if syntax == nil then
    return abort('No syntax')
  end

  local style = executeAppleScript('style.AppleScript')
  if style == nil then
    return abort('No style')
  end

  log.i('syntax "' .. syntax .. '", style "', style .. '"')

  local cmd = executable ..' -i '.. tmpFile ..' -O rtf --line-numbers --replace-tabs=2 --font-size=32 --font=Monaco --no-trailing-nl --syntax='.. syntax ..' --style='.. style
  local highlighted, _status, _type, _rc = hs.execute(cmd)

  local styledText = hs.styledtext.getStyledTextFromData(highlighted, 'rtf')
  hs.pasteboard.writeObjects(styledText)
  hs.notify.show('Highlight copied! 👻', '', 'Highlighted text has been added to the clipboard.')
end)

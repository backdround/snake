-- File describes object that can be used for receiven user key presses.
-- It returns one last key that is user pressed in termianl.

posix = require("posix")

local function new()
  local i = {}
  i.terminalState = posix.tcgetattr(posix.STDIN_FILENO)

  -- Configures terminal for get events without lock
  i.newAttributes = table.copy(i.terminalState)
  i.newAttributes.lflag = i.newAttributes.lflag & ~posix.ICANON & ~posix.ECHO
  i.newAttributes.cc[posix.VMIN] = 0
  i.newAttributes.cc[posix.VTIME] = 0
  assert(posix.tcsetattr(posix.STDIN_FILENO, posix.TCSANOW, i.newAttributes))

  -- Restores terminal in previous mode.
  function i:cleanup()
    assert(posix.tcsetattr(posix.STDIN_FILENO, posix.TCSANOW, self.terminalState))
  end

  -- Returns pressed key like that:
  -- { key = "left", directionKey = true, }
  function i:getEvent()
    local input = io.read()

    if not input then
      return nil
    end

    -- Checks direction key
    input = string.sub(input, -3)
    if input == "\27[A" then
      return { directionKey = true, key = "up", }
    elseif input == "\27[B" then
      return { directionKey = true, key = "down", }
    elseif input == "\27[C" then
      return { directionKey = true, key = "right", }
    elseif input == "\27[D" then
      return { directionKey = true, key = "left", }
    end

    -- Returns normal key
    return {
      directionKey = false,
      key = string.sub(input, -1),
    }
  end

  return i
end

return new

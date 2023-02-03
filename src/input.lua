-- File describes object that can be used for receiven user key presses.
-- It returns one last key that is user pressed in termianl.

posix = require("posix")

local function shallowcopy(t)
  copy = {}
  for key, value in pairs(t) do
    copy[key] = value
  end
  return copy
end

local function new()
  i = {}
  i.terminalState = posix.tcgetattr(posix.STDIN_FILENO)

  -- Configures terminal for get events without lock
  i.newAttributes = shallowcopy(i.terminalState)
  i.newAttributes.lflag = i.newAttributes.lflag & ~posix.ICANON & ~posix.ECHO
  i.newAttributes.cc[posix.VMIN] = 0
  i.newAttributes.cc[posix.VTIME] = 0
  assert(posix.tcsetattr(posix.STDIN_FILENO, posix.TCSANOW, i.newAttributes))

  -- Restores terminal in previous mode.
  function i:cleanup()
    assert(posix.tcsetattr(posix.STDIN_FILENO, posix.TCSANOW, self.terminalState))
  end

  -- Returns pressed key.
  function i:getEvent()
    input = io.read()

    if not input then
      return nil
    end

    input = string.sub(input, -3)
    if input == "\27[A" then
      return "up"
    elseif input == "\27[B" then
      return "down"
    elseif input == "\27[C" then
      return "right"
    elseif input == "\27[D" then
      return "left"
    end

    return string.sub(input, -1)
  end

  return i
end

return new

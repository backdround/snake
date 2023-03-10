#!/usr/bin/env lua

-- Inits
math.randomseed(os.time())

function table.copy (t)
   if type(t) == "table" then
      local copy = {}
      for key, value in pairs(t) do
         copy[key] = table.copy(value)
      end
      return copy
   else
      return t
   end
end

-- Creates terminator
local createTerminator = require('terminator')

local terminator = createTerminator()
local triggerTermination = function(...)
   terminator:trigger(...)
end

-- Creates game loop
local createGame = require('game')

local game, errorMessage = createGame(triggerTermination)
if not game then
   terminator:trigger(1, errorMessage)
   terminator:terminate()
end

terminator:onTerminate(function()
   game:cleanup()
end)


-- Inits event loop
local uv = require('luv')

-- Ticks game
local gameTimer = uv.new_timer()
gameTimer:start(0, 50, function()
   game:tick()
end)
terminator:onTrigger(function()
   uv.close(gameTimer)
end)

-- Handles sigint
local intSignal = uv.new_signal()
uv.signal_start(intSignal, "sigint", function()
   triggerTermination()
end)
terminator:onTrigger(function()
   uv.close(intSignal)
end)

-- Handles sigterm
local termSignal = uv.new_signal()
uv.signal_start(termSignal, "sigterm", function()
   triggerTermination()
end)
terminator:onTrigger(function()
   uv.close(termSignal)
end)


-- Launches appliaction
uv.run()

-- Cleans up aplication
terminator:terminate()

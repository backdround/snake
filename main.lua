#!/usr/bin/env lua

local uv = require('luv')

local function gameLoop()
   print("running")
end

local gameTimer = uv.new_timer()
gameTimer:start(250, 250, gameLoop)


local function exit(code, message)
   print(message or "exit")
   os.exit(code or 0)
end

local sigint = uv.new_signal()
uv.signal_start(sigint, "sigint", function()
   exit()
end)

local sigterm = uv.new_signal()
uv.signal_start(sigterm, "sigterm", function()
   exit()
end)

uv.run()

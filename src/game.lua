local createInput = require("input")

local function new(quit)
   game = {
      quit = quit
   }
   game.input = createInput()

   function game:tick()
      print("running")
      local event = self.input:getEvent()
      print("pressed: " .. tostring(event))
   end

   function game:cleanup()
      print("game cleanup")
      self.input:cleanup()
   end

   return game
end

return new

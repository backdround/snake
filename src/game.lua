local createInput = require("input")
local createField = require("field")

local function new(quit)
   game = {
      quit = quit
   }
   game.input = createInput()

   local field, errMessage = createField()
   if not field then
      return nil, errMessage
   end
   game.field = field

   function game:tick()
      local event = self.input:getEvent()
      self.field:render()
   end

   function game:cleanup()
      print("game cleanup")
      self.input:cleanup()
   end

   return game
end

return new

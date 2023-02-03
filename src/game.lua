local createInput = require("input")
local createField = require("field")
local createSnake = require("snake")

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

   game.snake = createSnake(game.field.width, game.field.height)

   function game:tick()
      local event = self.input:getEvent()
      if event then
         if event == "left" or
            event == "right" or
            event == "up" or
            event == "down" then
            self.snake:setDirection(event)
         end
      end
      self.snake:tick()
      self.field:render({self.snake})
   end

   function game:cleanup()
      print("game cleanup")
      self.input:cleanup()
   end

   return game
end

return new

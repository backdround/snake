local createInput = require("input")
local createField = require("field")
local createSnake = require("snake")
local createFood = require("food")


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
   game.food = createFood(game.field.width, game.field.height)

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
      if self.snake:isBumpIntoSelf() then
         self.quit()
      elseif self.food:consume(self.snake:getHead()) then
         self.snake:feed()
      else
         self.snake:forward()
      end
      self.field:render({self.snake, self.food})
   end

   function game:cleanup()
      self.input:cleanup()
      self.field:cleanup()
      print("game cleanup")
   end

   return game
end

return new

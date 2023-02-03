-- File describes game logic

local createInput = require("input")
local createField = require("field")
local createSnake = require("snake")
local createFood = require("food")

local function new(quit)
   local game = {
      quit = quit
   }
   game.input = createInput()

   local field, errMessage = createField()
   if not field then
      return nil, errMessage
   end
   game.field = field

   game.snake = createSnake(game.field:getSize())
   game.food = createFood(game.field:getSize())

   function game:tick()
      -- Handles user event
      local event = self.input:getEvent()
      if event then
         if event.directionKey then
            self.snake:setDirection(event.key)
         elseif event.key == " " then
            self.quit()
         end
      end

      -- Handles snake logic
      if self.snake:isBumpIntoSelf() then
         self.quit()
      elseif self.food:consume(self.snake:getHead()) then
         self.snake:feed()
      else
         self.snake:forward()
      end

      -- Renders
      local snakeObjects = self.snake:getRenderObjects()
      local foodObject = self.food:getRenderObject()
      self.field:render(foodObject, table.unpack(snakeObjects))
   end

   function game:cleanup()
      self.input:cleanup()
      self.field:cleanup()
   end

   return game
end

return new

inspect = require("inspect")

local function new(fieldWidth, fieldHeight)
   local snake = {
      fieldWidth = fieldWidth,
      fieldHeight = fieldHeight,
      direction = "right",
      bodySymbol = "#",
      bodyParts = {},
      head = {
         x = 0,
         y = math.floor(fieldHeight / 2),
      },
   }

   function snake:_getForwardCoordinates()
      local forwardCoordinates = {
         x = self.head.x,
         y = self.head.y,
      }

      -- Adds direction
      if self.direction == "left" then
         forwardCoordinates.x = forwardCoordinates.x - 1
      elseif self.direction == "right" then
         forwardCoordinates.x = forwardCoordinates.x + 1
      elseif self.direction == "up" then
         forwardCoordinates.y = forwardCoordinates.y - 1
      elseif self.direction == "down" then
         forwardCoordinates.y = forwardCoordinates.y + 1
      else
         error("unknown direction" .. self.direction)
      end

      -- Checks out of bounds
      if forwardCoordinates.y > self.fieldHeight then
         forwardCoordinates.y = 0
      elseif forwardCoordinates.y < 0 then
         forwardCoordinates.y = self.fieldHeight
      elseif forwardCoordinates.x > self.fieldWidth then
         forwardCoordinates.x = 0
      elseif forwardCoordinates.x < 0 then
         forwardCoordinates.x = self.fieldWidth
      end

      return forwardCoordinates
   end

   function snake:_pushBody()
      table.insert(self.bodyParts, 1, self.head)
      self.head = self:_getForwardCoordinates()
   end

   function snake:_popBody()
      table.remove(self.bodyParts)
   end

   function snake:symbol(x, y)
      for _, body in pairs(self.bodyParts) do
         if body.x == x and body.y == y then
            return self.bodySymbol
         end
      end
      return nil
   end

   function snake:setDirection(direction)
      self.direction = direction
   end

   function snake:tick(direction)
      snake:_pushBody()
      snake:_popBody()
   end

   -- Creates initial body parts
   for i = 1, 5 do
      snake:_pushBody()
   end

   return snake
end

return new

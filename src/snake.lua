-- File describes snake object

local function new(fieldWidth, fieldHeight)
   local snake = {
      fieldWidth = fieldWidth,
      fieldHeight = fieldHeight,
      direction = "right",
      bodyPartSymbol = "#",
      bodyParts = {},
      head = {
         x = 0,
         y = math.floor(fieldHeight / 2),
      },
   }

   -- Calculates the next cell in front of the snake's head.
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
         forwardCoordinates.y = 1
      elseif forwardCoordinates.y < 1 then
         forwardCoordinates.y = self.fieldHeight
      elseif forwardCoordinates.x > self.fieldWidth then
         forwardCoordinates.x = 1
      elseif forwardCoordinates.x < 1 then
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

   function snake:getRenderObjects()
      renderParts = {}

      -- Adds body parts
      for _, part in ipairs(self.bodyParts) do
         renderPart = {
            x = part.x,
            y = part.y,
            symbol = self.bodyPartSymbol,
         }
         table.insert(renderParts, renderPart)
      end

      -- Adds head
      table.insert(renderParts, {
            x = self.head.x,
            y = self.head.y,
            symbol = self.bodyPartSymbol
      })

      return renderParts
   end

   function snake:setDirection(direction)
      if (self.direction == "left" or self.direction == "right") and
         (direction == "left" or direction == "right") then
         -- Ignores case
         return
      end

      if (self.direction == "up" or self.direction == "down") and
         (direction == "up" or direction == "down") then
         -- Ignores case
         return
      end
      self.direction = direction
   end

   -- Makes the snake a cell forward.
   function snake:forward(direction)
      snake:_pushBody()
      snake:_popBody()
   end

   -- Makes the snake a cell bigger.
   function snake:feed(direction)
      snake:_pushBody()
   end

   -- Checks if snake is bump itself without any action.
   function snake:isBumpIntoSelf()
      for _, part in pairs(self.bodyParts) do
         if part.x == self.head.x and part.y == self.head.y then
            return true
         end
      end
      return false
   end

   function snake:getHead()
      return self.head.x, self.head.y
   end

   -- Creates initial body parts
   for i = 1, 5 do
      snake:_pushBody()
   end

   return snake
end

return new

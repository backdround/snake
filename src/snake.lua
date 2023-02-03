inspect = require("inspect")

local function new(width, height)
   local snake = {
      direction = "right",
      bodySymbol = "#",
      bodyParts = {},
      head = {
         x = 0,
         y = math.floor(height / 2),
      },
   }

   function snake:_getForwardCoordinates()
      local forwardCoordinates = {
         x = self.head.x,
         y = self.head.y,
      }

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

   for i = 1, 5 do
      snake:_pushBody()
   end

   return snake
end

return new

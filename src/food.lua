-- Represents a piece of snake food

local function new(fieldWidth, fieldHeight)
   local food = {
      fieldWidth = fieldWidth,
      fieldHeight = fieldHeight,
      x = 0,
      y = 0,
   }

   function food:_refresh()
      self.x = math.random(1, self.fieldWidth)
      self.y = math.random(1, self.fieldHeight)
   end

   -- Consumes the food if coordinates matches.
   function food:consume(x, y)
      if self.x == x and self.y == y then
         self:_refresh()
         return true
      end
      return false
   end

   function food:getRenderObject()
      return {
         x = self.x,
         y = self.y,
         symbol = "O",
      }
   end

   food:_refresh()

   return food
end

return new

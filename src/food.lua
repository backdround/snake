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

   function food:consume(x, y)
      if self.x == x and self.y == y then
         self:_refresh()
         return true
      end
      return false
   end

   function food:symbol(x, y)
      if self.x == x and self.y == y then
         return "O"
      end
      return nil
   end

   food:_refresh()

   return food
end

return new

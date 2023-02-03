-- File describes game field that is used for rendering in terminal.

local terminal = require("terminal")

-- Calculates suitable field size, based on terminal available size.
local function calculateFieldSize()
   local availableSize, errorMessage = terminal.getSize()
   if not availableSize then
      return {message = errorMessage}
   end

   local minSize = 13
   if availableSize.width < minSize or availableSize.height < minSize then
      return {
         message = "terminal size must be greater than " .. tonumber(minSize)
      }
   end

   local ratio = 2
   local width = availableSize.width / ratio
   local height = availableSize.height

   if math.floor(width) < height then
      width, height = width * ratio, math.floor(width)
   else
      width, height = height * ratio, height
   end

   assert(math.tointeger(width))
   assert(math.tointeger(height))

   return nil, width, height
end

local function new()
   local field = {}

   -- Gets size.
   local err, width, height = calculateFieldSize()
   if err then
      local errMessage = "Unable to get terminal size: " .. err.message
      return nil, errMessage
   end
   field.width = width
   field.height = height

   -- Draws game field in terminal.
   function field:render(objects)
      objects = objects or {}

      terminal.clear()
      for y = 1, self.height do
         for x = 1, self.width do
            local symbol = "."
            for _, object in ipairs(objects) do
               if object:symbol(x, y) then
                  symbol = object:symbol(x, y)
                  break
               end
            end

            io.write(symbol)
         end

         local last = y == self.height
         if last then
            io.flush()
         else
            io.write("\n")
         end
      end
   end

   function field:getSize()
      return self.width, self.height
   end

   function field:cleanup()
      terminal.clear()
   end

   return field
end

return new

local function new(quit)
   game = {
      quit = quit
   }

   function game:tick()
      print("running")
   end

   function game:cleanup()
      print("game cleanup")
   end

   return game
end

return new

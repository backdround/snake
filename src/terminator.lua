-- File describes terminator that is used for quiting application.

function new()
   t = {
      code = 0,
      message = "exiting",
      triggerCallbacks = {},
      terminateCallbacks = {},
   }

   -- Adds hook which is used for quiting application loop.
   function t:onTrigger(callback)
      table.insert(self.triggerCallbacks, callback)
   end

   -- Adds hook which is used for executing cleanups right before termination.
   function t:onTerminate(callback)
      table.insert(self.terminateCallbacks, callback)
   end

   -- Trigger quiting application loop.
   function t:trigger(code, message)
      self.code = code or self.code
      self.message = message or self.message

      for _, callback in ipairs(self.triggerCallbacks) do
         callback()
      end
   end

   -- Terminates application.
   function t:terminate()
      for _, callback in ipairs(self.terminateCallbacks) do
         callback()
      end

      print(self.message)
      os.exit(self.code)
   end

   return t
end

return new

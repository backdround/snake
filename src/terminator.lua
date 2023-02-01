function new()
   t = {
      code = 0,
      message = "exiting",
      triggerCallbacks = {},
      terminateCallbacks = {},
   }

   function t:onTrigger(callback)
      table.insert(self.triggerCallbacks, callback)
   end

   function t:onTerminate(callback)
      table.insert(self.terminateCallbacks, callback)
   end

   function t:trigger(code, message)
      self.code = code or self.code
      self.message = message or self.message

      for _, callback in ipairs(self.triggerCallbacks) do
         callback()
      end
   end

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

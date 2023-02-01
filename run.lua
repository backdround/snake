#!/usr/bin/env lua

local version = _VERSION:match('%d+%.%d+')

-- Modules
package.path = "./lua_modules/share/lua/" .. version .. "/?.lua;" .. package.path
package.path = "./lua_modules/share/lua/" .. version .. "/?/init.lua;" .. package.path
package.cpath = "./lua_modules/lib/lua/" .. version .. "/?.so;;" .. package.cpath

-- Sources
package.path = "./src/?.lua;" .. package.path

dofile("./src/main.lua")

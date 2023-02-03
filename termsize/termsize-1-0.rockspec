package = "termsize"
version = "1-0"
dependencies = {
   "lua >= 5.4",
}
build = {
   type = "builtin",
   modules = {
      termsize = {
         sources = { "./main.c" },
      },
   },
}
source = {
   url = "git://github.com/backdround/lua-snake.git",
}

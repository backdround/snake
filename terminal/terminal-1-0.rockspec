package = "terminal"
version = "1-0"
dependencies = {
   "lua >= 5.4",
}
build = {
   type = "builtin",
   modules = {
      terminal = {
         sources = { "./main.c" },
      },
   },
}
source = {
   url = "git://github.com/backdround/snake.git",
}

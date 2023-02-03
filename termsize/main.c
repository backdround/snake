#include <lua.h>
#include <lauxlib.h>

#include <sys/ioctl.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>

static int l_get(lua_State* L) {
    struct winsize size;

    int r = ioctl(STDOUT_FILENO, TIOCGWINSZ, &size);
    if (r != 0) {
        lua_pushnil(L);
        lua_pushstring(L, strerror(errno));
        return 2;
    }

    lua_newtable(L);

    lua_pushinteger(L, size.ws_row);
    lua_setfield(L, -2, "height");

    lua_pushinteger(L, size.ws_col);
    lua_setfield(L, -2, "width");

    return 1;
}

static const struct luaL_Reg functions[] = {
    {"get", l_get},
    {NULL, NULL}
};

int luaopen_termsize(lua_State* L) {
    luaL_newlib(L, functions);
    return 1;
}

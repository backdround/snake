#include <lua.h>
#include <lauxlib.h>

#include <sys/ioctl.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>

// Gets terminal available size.
// Returns table with `.width` and `.height` on success.
// Returns nil and error message on fail.
static int l_getSize(lua_State* L) {
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

// Clears terminal output.
static int l_clear(lua_State* L) {
    printf("\33[H\33[J\33[3J");
    fflush(stdout);
    return 0;
}

static const struct luaL_Reg functions[] = {
    {"getSize", l_getSize},
    {"clear", l_clear},
    {NULL, NULL}
};

int luaopen_terminal(lua_State* L) {
    luaL_newlib(L, functions);
    return 1;
}

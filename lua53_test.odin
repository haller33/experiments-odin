package main

import libc "core:c"
import "core:fmt"
import lua54 "vendor:lua/5.4"


main :: proc() {


  StateL := lua54.L_newstate()

  lua54.L_openlibs(StateL)

  ret: lua54.Status = lua54.L_loadfile(StateL, "lua_script_lua54_test.lua")

  if !(ret == lua54.Status.OK) {
    lua54.L_error(StateL, "lua LoadFile Failed\n")
  }


  fmt.println("In Odin, calling Lua\n")

  int_ret: libc.int = lua54.pcall(StateL, 0, 0, 0, 0)
  if !(int_ret == 0) {
    fmt.println(StateL)
    lua54.L_error(StateL, "lua pcall() Failed\n")
  }

  fmt.println(StateL)

  fmt.println("Back in Odin again\n")

  return

}

main_test :: proc() {

  cmd: cstring = "a = 7 + 11"
  _luastate := lua54.L_newstate()

  fmt.println(cmd)

  result: libc.int = lua54.L_dostring(_luastate, cmd)

  fmt.println(result)

  if (result == auto_cast lua54.OK) {
    fmt.println("working?")
  } else {
    errormsg: cstring = lua54.tostring(_luastate, -1)
    fmt.println(errormsg)
  }

}

package triangle_hello
// attempt to do the hello triangle


import "core:fmt"
import gl "vendor:OpenGL"
import glfw "vendor:glfw"

import libc "core:c"

TITLE :: "Test Window"

SCREEN_WITH :: 800
SCREEN_HEIGHT :: 600

framebuffer_size_callback :: proc "c" (
  window: glfw.WindowHandle,
  width_local, height_local: libc.int,
) {

  gl.Viewport(0, 0, width_local, height_local)
}

main :: proc() {

  fmt.println("Hello World")

  glfw.Init()
  glfw.WindowHint(glfw.CONTEXT_VERSION_MAJOR, 3)
  glfw.WindowHint(glfw.CONTEXT_VERSION_MINOR, 3)
  glfw.WindowHint(glfw.OPENGL_PROFILE, glfw.OPENGL_CORE_PROFILE)

  window_handle: glfw.WindowHandle = glfw.CreateWindow(
    SCREEN_WITH,
    SCREEN_HEIGHT,
    TITLE,
    nil,
    nil,
  )

  defer glfw.Terminate()
  defer glfw.DestroyWindow(window_handle)

  glfw.MakeContextCurrent(window_handle)

  glfw.SetFramebufferSizeCallback(window_handle, framebuffer_size_callback)

  gl.load_up_to(
    glfw.VERSION_MAJOR,
    glfw.VERSION_MINOR,
    glfw.gl_set_proc_address,
  )

  for !bool(glfw.WindowShouldClose(window_handle)) {

    process_input(window_handle)

    gl.ClearColor(0.2, 0.3, 0.3, 1.0)
    gl.Clear(gl.COLOR_BUFFER_BIT)

    glfw.SwapBuffers(window_handle)
    glfw.PollEvents()
  }

  return
}

process_input :: proc(window_handle: glfw.WindowHandle) {


  if glfw.GetKey(window_handle, glfw.KEY_ESCAPE) == glfw.PRESS {
    glfw.SetWindowShouldClose(window_handle, true)
  }
}

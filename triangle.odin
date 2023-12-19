package triangle_hello
// attempt to do the hello triangle


import "core:fmt"
import gl "vendor:OpenGL"
import glfw "vendor:glfw"

import libc "core:c"

TITLE :: "Test Window"

SCREEN_WITH :: 800
SCREEN_HEIGHT :: 600


framebuffer_size_callback :: proc "c" (window: glfw.WindowHandle, width_local, height_local: libc.int) {

  gl.Viewport(0, 0, width_local, height_local)
}

main :: proc() {

  fmt.println("Hello World")

  glfw.Init()
  glfw.WindowHint(glfw.CONTEXT_VERSION_MAJOR, 3)
  glfw.WindowHint(glfw.CONTEXT_VERSION_MINOR, 3)
  glfw.WindowHint(glfw.OPENGL_PROFILE, glfw.OPENGL_CORE_PROFILE)

  wiwndow_handle: glfw.WindowHandle = glfw.CreateWindow(
    SCREEN_WITH,
    SCREEN_HEIGHT,
    TITLE,
    nil,
    nil,
  )

  defer glfw.Terminate()
  defer glfw.DestroyWindow(wiwndow_handle)

  glfw.MakeContextCurrent(wiwndow_handle)

  glfw.SetFramebufferSizeCallback(wiwndow_handle, framebuffer_size_callback)

  gl.load_up_to(
    glfw.VERSION_MAJOR,
    glfw.VERSION_MINOR,
    glfw.gl_set_proc_address,
  )

  for !bool(glfw.WindowShouldClose(wiwndow_handle)) {

    if glfw.GetKey(wiwndow_handle, glfw.KEY_ESCAPE) == glfw.PRESS {
      glfw.SetWindowShouldClose(wiwndow_handle, true)
    }

    glfw.SwapBuffers(wiwndow_handle)
    glfw.PollEvents()
  }

  return
}

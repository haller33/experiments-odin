package context_monad

import "core:fmt"
import "core:mem"

// SSA
// https://www.cs.purdue.edu/homes/suresh/502-Fall2008/papers/kelsey-ssa-cps.pdf
a_global: int = 0

multplo_global :: proc(base_of: int) -> proc(_: int) -> int {

  a_global = base_of
  return proc(num_test: int) -> int {

      return a_global * num_test
    }
}

// https://arxiv.org/pdf/1803.10195.pdf
multplo_monadic :: proc(
  monad_context: ^int,
  base_of: int,
) -> (
  ^int,
  proc(_: ^int, _: int) -> (^int, int),
) {

  monad_context^ = base_of
  return monad_context,
    proc(monad_context: ^int, num_test: int) -> (^int, int) {

      return monad_context, ((cast(int)monad_context^) * num_test)
    }
}


multplo_context :: proc(
  base_of: int,
  m := context.user_ptr,
) -> proc(_: int, _: rawptr) -> int {

  (cast(^int)m)^ = base_of
  return proc(num_test: int, m := context.user_ptr) -> int {

      return (cast(^int)m)^ * num_test
    }
}


main :: proc() {

  {

    // unitMonad :: 0
    data_base: int = 2
    unitMonad: int = 0
    monadC: ^int
    tmp: int
    multTwo: proc(_: ^int, _: int) -> (^int, int)
    // context.user_ptr = &data
    monadC, multTwo = multplo_monadic(&unitMonad, data_base)

    monadC, tmp = multTwo(monadC, 10)

    fmt.println(tmp)

  }


  {
    data: int
    multTwo: proc(_: int, _: rawptr) -> int
    //
    context.user_ptr = (cast(rawptr)&data)

    multTwo = multplo_context(2)

    tmp := multTwo(10, context.user_ptr)

    fmt.println(tmp)

  }
}

// import gleam/int
// import gleam/result
import glick80_api as tic_api

pub type State {
  State(t: Int, x: Int, y: Int)
}

pub const initial_state = State(0, 96, 24)

fn delta_x() -> Int {
  case tic_api.btn(2), tic_api.btn(3) {
    True, _ -> -1
    _, True -> 1
    _, _ -> 0
  }
}

fn delta_y() -> Int {
  case tic_api.btn(0), tic_api.btn(1) {
    True, _ -> -1
    _, True -> 1
    _, _ -> 0
  }
}

pub fn frame(state: State) -> State {
  let State(t, x0, y0) = state

  let x1 = x0 + delta_x()
  let y1 = y0 + delta_y()

  tic_api.cls(13)

  let id = 1
  // TODO:
  // 1 + int.modulo(t, 60)
  // |> int.divide(30)
  // |> result.unwrap(0)
  // * 2

  tic_api.spr(id, x1, y1, 14, 3, 0, 0, 2, 2)
  tic_api.print_("HELLO WORLD!", 84, 84)

  State(t + 1, x1, y1)
}

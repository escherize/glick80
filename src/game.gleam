import glick80_api as g

pub type V2 {
  V2(x: Float, y: Float)
}

pub type Player {
  Player(pos: V2, vel: V2, speed: Float)
}

pub type State {
  State(t: Int, p: Player)
}

pub const initial_state = State(
  t: 0,
  p: Player(pos: V2(96.0, 24.0), vel: V2(0.0, 0.0), speed: 1.0),
)

fn dir(neg_pressed: Bool, pos_pressed: Bool) -> Float {
  case neg_pressed, pos_pressed {
    True, False -> -1.0
    False, True -> 1.0
    _, _ -> 0.0
  }
}

fn clamp(x: Float, lo: Float, hi: Float) -> Float {
  case x <. lo, x >. hi {
    True, _ -> lo
    _, True -> hi
    _, _ -> x
  }
}

fn v2add(a: V2, b: V2) -> V2 {
  let V2(ax, ay) = a
  let V2(bx, by) = b
  V2(ax +. bx, ay +. by)
}

fn scale(a: V2, s: Float) -> V2 {
  let V2(ax, ay) = a
  V2(ax *. s, ay *. s)
}

pub fn update(state: State) -> State {
  let State(t, Player(pos, vel, speed)) = state
  let up = g.btn(0)
  let down = g.btn(1)
  let left = g.btn(2)
  let right = g.btn(3)

  let v_next =
    V2(
      clamp(vel.x +. dir(left, right), 0.0 -. speed, speed),
      clamp(vel.y +. dir(up, down), 0.0 -. speed, speed),
    )
    |> scale(0.9)
  let p_next = Player(v2add(pos, v_next), v_next, speed)
  State(t + 1, p_next)
}

pub fn draw(state: State) -> Nil {
  let State(_t, Player(pos, _vel, _speed)) = state
  let id: Int = 1
  g.cls(14)
  g.print(g.mouse(), 10, 10)
  g.spr_full(id, pos.x, pos.y, ck: -1, scale: 3.0, flip: 0, rot: 0, w: 2, h: 2)
  g.print("HELLO WORLD!", 84, 84)
  Nil
}

@external(javascript, "../tic_ffi.mjs", "spr")
pub fn spr(
  id: Int,
  x: Int,
  y: Int,
  colorkey: Int,
  scale: Int,
  flip: Int,
  rotate: Int,
  w: Int,
  h: Int,
) -> Nil

@external(javascript, "../tic_ffi.mjs", "btn")
pub fn btn(id: Int) -> Bool

@external(javascript, "../tic_ffi.mjs", "cls")
pub fn cls(color: Int) -> Nil

@external(javascript, "../tic_ffi.mjs", "print")
pub fn print_(text: String, x: Int, y: Int) -> Nil

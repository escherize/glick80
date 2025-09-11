pub type Void

@external(javascript, "globalThis", "spr")
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
) -> Void

@external(javascript, "globalThis", "btn")
pub fn btn(id: Int) -> Bool

@external(javascript, "globalThis", "cls")
pub fn cls(color: Int) -> Void

@external(javascript, "globalThis", "print")
pub fn print(text: String, x: Int, y: Int) -> Void

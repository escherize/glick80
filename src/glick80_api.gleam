// import gleam/list
import gleam/string

@external(javascript, "../tic_ffi.mjs", "circ")
pub fn circ_(radius: Int, x: Int, y: Int, color: Int) -> Nil

@external(javascript, "../tic_ffi.mjs", "circb")
pub fn circb_(radius: Int, x: Int, y: Int, color: Int) -> Nil

pub type ClipCfg {
  ClipCfg(x: Int, y: Int, width: Int, height: Int)
  Reset
}

// Clear the screen
pub type ClsCfg {
  ClsCfg(color: Int)
}

@external(javascript, "../tic_ffi.mjs", "cls")
pub fn cls_(color: Int) -> Nil

// Draw a straight line
pub type LineCfg {
  LineCfg(x0: Int, y0: Int, x1: Int, y1: Int, color: Int)
}

// Print a string using the system font
pub type PrintCfg {
  PrintCfg(text: String, x: Int, y: Int)
}

// Draw a filled rectangle
// Draw a rectangle border
pub type RectCfg {
  RectCfg(x: Int, y: Int, width: Int, height: Int, color: Int)
}

@external(javascript, "../tic_ffi.mjs", "rect")
pub fn rect_(x: Int, y: Int, width: Int, height: Int, color: Int) -> Nil

@external(javascript, "../tic_ffi.mjs", "rectb")
pub fn rectb_(x: Int, y: Int, width: Int, height: Int, color: Int) -> Nil

// Draw a filled triangle
pub type TriCfg {
  TriCfg(x0: Int, y0: Int, x1: Int, y1: Int, x2: Int, y2: Int, color: Int)
}

pub fn cls(color: Int) -> Nil {
  cls_(color)
}

// ### spr
// `spr(id x y colorkey=-1 scale=1 flip=0 rotate=0 w=1 h=1)`
// Draws the sprite number index at the x and y coordinate.
// You can specify a colorkey in the palette which will be used as the transparent color or use a value of -1 for an opaque sprite.
// The sprite can be scaled up by a desired factor. For example, a scale factor of 2 means an 8x8 pixel sprite is drawn to a 16x16 area of the screen.
// You can flip the sprite where:
// - 0 = No Flip
// - 1 = Flip horizontally
// - 2 = Flip vertically
// - 3 = Flip both vertically and horizontally
// When you rotate the sprite, it's rotated clockwise in 90 steps:
// - 0 = No rotation
// - 1 = 90 rotation
// - 2 = 180 rotation
// - 3 = 270 rotation
// You can draw a composite sprite (consisting of a rectangular region of sprites from the sprite sheet) by specifying the `w` and `h` parameters (which default to 1).

pub fn spr(id: Int, x: Float, y: Float) -> Nil {
  spr_full(id, x, y, -1, 1.0, 0, 0, 1, 1)
}

@external(javascript, "../tic_ffi.mjs", "spr")
pub fn spr_full(
  id: Int,
  x: Float,
  y: Float,
  ck colorkey: Int,
  scale scale: Float,
  flip flip: Int,
  rot rotate: Int,
  w width: Int,
  h height: Int,
) -> Nil

pub fn print(text: anything, x: Int, y: Int) -> Nil {
  print_(string.inspect(text), x, y)
}

@external(javascript, "../tic_ffi.mjs", "print")
pub fn print_(text: String, x: Int, y: Int) -> Nil

pub fn btn(id: Int) -> Bool {
  btn_(id)
}

@external(javascript, "../tic_ffi.mjs", "btn")
pub fn btn_(id: Int) -> Bool

// ### btnp
// `btnp(id hold=-1 period=-1) -> pressed`
// This function allows you to read the status of one of TIC's buttons.
// It returns true only if the key has been pressed since the last frame.
// You can also use the optional hold and period parameters which allow you to check if a button is being held down.
// After the time specified by hold has elapsed, btnp will return true each time period is passed if the key is still down.
// For example, to re-examine the state of button `0` after 2 seconds and continue to check its state every 1/10th of a second, you would use btnp(0, 120, 6).
// Since time is expressed in ticks and TIC runs at 60 frames per second, we use the value of 120 to wait 2 seconds and 6 ticks (ie 60/10) as the interval for re-checking.

@external(javascript, "../tic_ffi.mjs", "btnp")
pub fn btnp_(id: Int) -> Bool

@external(javascript, "../tic_ffi.mjs", "btnp")
pub fn btnp_hold(id: Int, hold: Int) -> Bool

@external(javascript, "../tic_ffi.mjs", "btnp")
pub fn btnp_full(id: Int, hold: Int, period: Int) -> Bool

// ### mouse
// `mouse() -> x y left middle right scrollx scrolly`
// This function returns the mouse coordinates and a boolean value for the state of each mouse button,with true indicating that a button is pressed.

pub type Mouse {
  Mouse(
    x: Int,
    y: Int,
    left: Bool,
    middle: Bool,
    right: Bool,
    scrollx: Int,
    scrolly: Int,
  )
}

pub fn mouse() -> Mouse {
  let m = mouse_()
  Mouse(m.0, m.1, m.2, m.3, m.4, m.5, m.6)
}

@external(javascript, "../tic_ffi.mjs", "mouse")
pub fn mouse_() -> #(Int, Int, Bool, Bool, Bool, Int, Int)

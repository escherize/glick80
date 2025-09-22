// import gleam/list
import gleam/string

// ### btn
// `btn(id) -> pressed`
// This function allows you to read the status of one of the buttons attached to TIC.
// The function returns true if the key with the supplied id is currently in the pressed state.
// It remains true for as long as the key is held down.
// If you want to test if a key was just pressed, use `btnp()` instead.

@external(javascript, "../tic_ffi.mjs", "btn")
pub fn btn(id: Int) -> Bool

// ### btnp
// `btnp(id hold=-1 period=-1) -> pressed`
// This function allows you to read the status of one of TIC's buttons.
// It returns true only if the key has been pressed since the last frame.
// You can also use the optional hold and period parameters which allow you to check if a button is being held down.
// After the time specified by hold has elapsed, btnp will return true each time period is passed if the key is still down.
// For example, to re-examine the state of button `0` after 2 seconds and continue to check its state every 1/10th of a second, you would use btnp(0, 120, 6).
// Since time is expressed in ticks and TIC runs at 60 frames per second, we use the value of 120 to wait 2 seconds and 6 ticks (ie 60/10) as the interval for re-checking.

@external(javascript, "../tic_ffi.mjs", "btnp")
pub fn btnp(id: Int) -> Bool

@external(javascript, "../tic_ffi.mjs", "btnp")
pub fn btnp_hold(id: Int, hold: Int) -> Bool

@external(javascript, "../tic_ffi.mjs", "btnp")
pub fn btnp_full(id: Int, hold: Int, period: Int) -> Bool

// ### circ
// `circ(x y radius color)`
// This function draws a filled circle of the desired radius and color with its center at x, y.
// It uses the Bresenham algorithm.

@external(javascript, "../tic_ffi.mjs", "circ")
pub fn circ(x x: Int, y y: Int, radius r: Int, color clr: Int) -> Nil

// ### circb
// `circb(x y radius color)`
// Draws the circumference of a circle with its center at x, y using the radius and color requested.
// It uses the Bresenham algorithm.

@external(javascript, "../tic_ffi.mjs", "circb")
pub fn circb(x: Int, y: Int, radius: Int, color: Int) -> Nil

// ### clip
// `clip(x y width height)
// clip()`
// This function limits drawing to a clipping region or `viewport` defined by x,y,w,h.
// Things drawn outside of this area will not be visible.
// Calling clip() with no parameters will reset the drawing area to the entire screen.

pub type Clip {
  Clip(x: Int, y: Int, width: Int, height: Int)
  Reset
}

pub fn clip(c: Clip) {
  case c {
    Clip(x, y, w, h) -> clip_(x, y, w, h)
    Reset -> clip_reset_()
  }
}

@external(javascript, "../tic_ffi.mjs", "clip")
pub fn clip_(x: Int, y: Int, w: Int, h: Int) -> Nil

@external(javascript, "../tic_ffi.mjs", "clip_reset")
pub fn clip_reset_() -> Nil

// ### cls
// `cls(color=0)`
// Clear the screen.
// When called this function clear all the screen using the color passed as argument.
// If no parameter is passed first color (0) is used.

@external(javascript, "../tic_ffi.mjs", "cls")
pub fn cls(color: Int) -> Nil

// ### elli
// `elli(x y a b color)`
// This function draws a filled ellipse of the desired a, b radiuses and color with its center at x, y.
// It uses the Bresenham algorithm.

@external(javascript, "../tic_ffi.mjs", "elli")
pub fn elli(x: Int, y: Int, a: Int, b: Int, color: Int) -> Nil

// ### ellib
// `ellib(x y a b color)`
// This function draws an ellipse border with the desired radiuses a b and color with its center at x, y.
// It uses the Bresenham algorithm.

@external(javascript, "../tic_ffi.mjs", "ellib")
pub fn ellib(x: Int, y: Int, a: Int, b: Int, color: Int) -> Nil

// ### exit
// `exit()`
// Interrupts program execution and returns to the console when the TIC function ends.

@external(javascript, "../tic_ffi.mjs", "exit")
pub fn exit() -> Nil

// ### fget
// `fget(sprite_id flag) -> bool`
// Returns true if the specified flag of the sprite is set. See `fset()` for more details.

@external(javascript, "../tic_ffi.mjs", "fget")
pub fn fget(sprite_id: Int, flag: Int) -> Bool

// ### font
// `font(text x y chromakey char_width char_height fixed=false scale=1 alt=false) -> width`
// Print string with font defined in foreground sprites.
// To simply print to the screen, check out `print()`.
// To print to the console, check out `trace()`.

pub fn font(
  text: anything,
  x: Int,
  y: Int,
  chromakey: Int,
  char_width: Int,
  char_height: Int,
) -> Int {
  font_(
    string.inspect(text),
    x,
    y,
    chromakey,
    char_width,
    char_height,
    False,
    1.0,
    False,
  )
}

pub fn font_full(
  text: anything,
  x: Int,
  y: Int,
  chromakey: Int,
  char_width: Int,
  char_height: Int,
  fixed: Bool,
  scale: Float,
  alt: Bool,
) -> Int {
  font_(
    string.inspect(text),
    x,
    y,
    chromakey,
    char_width,
    char_height,
    fixed,
    scale,
    alt,
  )
}

@external(javascript, "../tic_ffi.mjs", "font")
fn font_(
  text: String,
  x: Int,
  y: Int,
  chromakey: Int,
  char_width: Int,
  char_height: Int,
  fixed: Bool,
  scale: Float,
  alt: Bool,
) -> Int

// ### fset
// `fset(sprite_id flag bool)`
// Each sprite has eight flags which can be used to store information or signal different conditions.
// For example, flag 0 might be used to indicate that the sprite is invisible, flag 6 might indicate that the flag should be draw scaled etc.
// See algo `fget()`.

@external(javascript, "../tic_ffi.mjs", "fset")
pub fn fset(sprite_id: Int, flag: Int, value: Bool) -> Nil

// ### key
// `key(code=-1) -> pressed`
// The function returns true if the key denoted by keycode is pressed.

@external(javascript, "../tic_ffi.mjs", "key")
pub fn key(code: Int) -> Bool

// ### keyp
// `keyp(code=-1 hold=-1 period=-1) -> pressed`
// This function returns true if the given key is pressed but wasn't pressed in the previous frame.
// Refer to `btnp()` for an explanation of the optional hold and period parameters.

pub fn keyp(code: Int) -> Bool {
  keyp_(code, -1, -1)
}

pub fn keyp_hold(code: Int, hold: Int) -> Bool {
  keyp_(code, hold, -1)
}

pub fn keyp_full(code: Int, hold: Int, period: Int) -> Bool {
  keyp_(code, hold, period)
}

@external(javascript, "../tic_ffi.mjs", "keyp")
fn keyp_(code: Int, hold: Int, period: Int) -> Bool

// ### line
// `line(x0 y0 x1 y1 color)`
// Draws a straight line from point (x0,y0) to point (x1,y1) in the specified color.

@external(javascript, "../tic_ffi.mjs", "line")
pub fn line(x0: Int, y0: Int, x1: Int, y1: Int, color: Int) -> Nil

// ### map
// `map(x=0 y=0 w=30 h=17 sx=0 sy=0 colorkey=-1 scale=1 remap=nil)`
// The map consists of cells of 8x8 pixels, each of which can be filled with a sprite using the map editor.
// The map can be up to 240 cells wide by 136 deep.
// This function will draw the desired area of the map to a specified screen position.
// For example, map(5,5,12,10,0,0) will draw a 12x10 section of the map, starting from map coordinates (5,5) to screen position (0,0).
// The map function's last parameter is a powerful callback function for changing how map cells (sprites) are drawn when map is called.
// It can be used to rotate, flip and replace sprites while the game is running.
// Unlike mset, which saves changes to the map, this special function can be used to create animated tiles or replace them completely.
// Some examples include changing sprites to open doorways, hiding sprites used to spawn objects in your game and even to emit the objects themselves.
// The tilemap is laid out sequentially in RAM - writing 1 to 0x08000 will cause tile(sprite) #1 to appear at top left when map() is called.
// To set the tile immediately below this we need to write to 0x08000 + 240, ie 0x080F0.

pub fn map(x: Int, y: Int, w: Int, h: Int, sx: Int, sy: Int) -> Nil {
  map_full(x, y, w, h, sx, sy, -1, 1.0, Nil)
}

pub fn map_ck(
  x: Int,
  y: Int,
  w: Int,
  h: Int,
  sx: Int,
  sy: Int,
  colorkey: Int,
) -> Nil {
  map_(x, y, w, h, sx, sy, colorkey, 1.0, Nil)
}

pub fn map_ck_scale(
  x: Int,
  y: Int,
  w: Int,
  h: Int,
  sx: Int,
  sy: Int,
  colorkey: Int,
  scale: Float,
) -> Nil {
  map_(x, y, w, h, sx, sy, colorkey, scale, Nil)
}

pub fn map_full(
  x: Int,
  y: Int,
  w: Int,
  h: Int,
  sx: Int,
  sy: Int,
  colorkey: Int,
  scale: Float,
  remap: anything,
  // TODO: what is remap's type?
) -> Nil {
  map_(x, y, w, h, sx, sy, colorkey, scale, remap)
}

@external(javascript, "../tic_ffi.mjs", "map")
fn map_(
  x x: Int,
  y y: Int,
  w w: Int,
  h h: Int,
  sx sx: Int,
  sy sy: Int,
  ck colorkey: Int,
  scale scale: Float,
  remap remap: anything,
) -> Nil

// ### memcpy
// `memcpy(dest source size)`
// This function allows you to copy a continuous block of TIC's 96K RAM from one address to another.
// Addresses are specified are in hexadecimal format, values are decimal.

@external(javascript, "../tic_ffi.mjs", "memcpy")
pub fn memcpy(dest: Int, source: Int, size: Int) -> Nil

// ### memset
// `memset(dest value size)`
// This function allows you to set a continuous block of any part of TIC's RAM to the same value.
// The address is specified in hexadecimal format, the value in decimal.

@external(javascript, "../tic_ffi.mjs", "memset")
pub fn memset(dest: Int, value: Int, size: Int) -> Nil

// ### mget
// `mget(x y) -> tile_id`
// Gets the sprite id at the given x and y map coordinate.

@external(javascript, "../tic_ffi.mjs", "mget")
pub fn mget(x: Int, y: Int) -> Int

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

// ### mset
// `mset(x y tile_id)`
// This function will change the tile at the specified map coordinates.
// By default, changes made are only kept while the current game is running.
// To make permanent changes to the map, see `sync()`.
// Related: `map()` `mget()` `sync()`.

@external(javascript, "../tic_ffi.mjs", "mset")
pub fn mset(x: Int, y: Int, tile_id: Int) -> Nil

// ### music
// `music(track=-1 frame=-1 row=-1 loop=true sustain=false tempo=-1 speed=-1)`
// This function starts playing a track created in the Music Editor.
// Call without arguments to stop the music.

pub fn music(track: Int, frame: Int, row: Int) -> Nil {
  music_(track, frame, row, True, False, -1, -1)
}

pub fn music_full(
  track: Int,
  frame: Int,
  row: Int,
  loop: Bool,
  sustain: Bool,
  tempo: Int,
  speed: Int,
) -> Nil {
  music_(track, frame, row, loop, sustain, tempo, speed)
}

@external(javascript, "../tic_ffi.mjs", "music")
fn music_(
  track: Int,
  frame: Int,
  row: Int,
  loop: Bool,
  sustain: Bool,
  tempo: Int,
  speed: Int,
) -> Nil

// ### peek
// `peek(addr bits=8) -> value`
// This function allows to read the memory from TIC.
// It's useful to access resources created with the integrated tools like sprite, maps, sounds, cartridges data?
// Never dream to sound a sprite?
// Address are in hexadecimal format but values are decimal.
// To write to a memory address, use `poke()`.
// `bits` allowed to be 1,2,4,8.

pub type Bits {
  Bit1
  Bit2
  Bit4
  Bit8
}

fn bit_to_int(bits: Bits) -> Int {
  case bits {
    Bit1 -> 1
    Bit2 -> 2
    Bit4 -> 4
    Bit8 -> 8
  }
}

pub fn peek(addr: Int) -> Int {
  peek_bits(addr, Bit8)
}

pub fn peek_bits(addr: Int, bits: Bits) -> Int {
  peek_(addr, bit_to_int(bits))
}

@external(javascript, "../tic_ffi.mjs", "peek")
fn peek_(addr: Int, bits: Int) -> Int

// ### peek1
// `peek1(addr) -> value`
// This function enables you to read single bit values from TIC's RAM.
// The address is often specified in hexadecimal format.

@external(javascript, "../tic_ffi.mjs", "peek1")
pub fn peek1(addr: Int) -> Int

// ### peek2
// `peek2(addr) -> value`
// This function enables you to read two bits values from TIC's RAM.
// The address is often specified in hexadecimal format.

@external(javascript, "../tic_ffi.mjs", "peek2")
pub fn peek2(addr: Int) -> Int

// ### peek4
// `peek4(addr) -> value`
// This function enables you to read values from TIC's RAM.
// The address is often specified in hexadecimal format.
// See 'poke4()' for detailed information on how nibble addressing compares with byte addressing.

@external(javascript, "../tic_ffi.mjs", "peek4")
pub fn peek4(addr: Int) -> Int

// ### pix
// `pix(x y color)
// pix(x y) -> color`
// This function can read or write pixel color values.
// When called with a color parameter, the pixel at the specified coordinates is set to that color.
// Calling the function without a color parameter returns the color of the pixel at the specified position.

@external(javascript, "../tic_ffi.mjs", "pix")
pub fn set_pix(x: Int, y: Int, color: Int) -> Nil

@external(javascript, "../tic_ffi.mjs", "pix")
pub fn get_pix(x: Int, y: Int) -> Int

// ### pmem
// `pmem(index value)
// pmem(index) -> value`
// This function allows you to save and retrieve data in one of the 256 individual 32-bit slots available in the cartridge's persistent memory.
// This is useful for saving high-scores, level advancement or achievements.
// The data is stored as unsigned 32-bit integers (from 0 to 4294967295).
//
// Tips:
// - pmem depends on the cartridge hash (md5), so don't change your lua script if you want to keep the data.
// - Use `saveid:` with a personalized string in the header metadata to override the default MD5 calculation.
// This allows the user to update a cart without losing their saved data.
@external(javascript, "../tic_ffi.mjs", "pmem")
pub fn pmem_set(index: Int, value: Int) -> Nil

@external(javascript, "../tic_ffi.mjs", "pmem")
pub fn pmem_get(index: Int) -> Int

// ### poke
// `poke(addr value bits=8)`
// This function allows you to write a single byte to any address in TIC's RAM.
// The address should be specified in hexadecimal format, the value in decimal.
// `bits` allowed to be 1,2,4,8.

pub fn poke(addr: Int, value: Int) -> Nil {
  poke_bits(addr, value, Bit8)
}

pub fn poke_bits(addr: Int, value: Int, bits: Bits) -> Nil {
  poke_(addr, value, bit_to_int(bits))
}

@external(javascript, "../tic_ffi.mjs", "poke")
fn poke_(addr: Int, value: Int, bits: Int) -> Nil

// ### poke1
// `poke1(addr value)`
// This function allows you to write single bit values directly to RAM.
// The address is often specified in hexadecimal format.

@external(javascript, "../tic_ffi.mjs", "poke1")
pub fn poke1(addr: Int, value: Int) -> Nil

// ### poke2
// `poke2(addr value)`
// This function allows you to write two bits values directly to RAM.
// The address is often specified in hexadecimal format.

@external(javascript, "../tic_ffi.mjs", "poke2")
pub fn poke2(addr: Int, value: Int) -> Nil

// ### poke4
// `poke4(addr value)`
// This function allows you to write directly to RAM.
// The address is often specified in hexadecimal format.
// For both peek4 and poke4 RAM is addressed in 4 bit segments (nibbles).
// Therefore, to access the the RAM at byte address 0x4000
// you would need to access both the 0x8000 and 0x8001 nibble addresses.

@external(javascript, "../tic_ffi.mjs", "poke4")
pub fn poke4(addr: Int, value: Int) -> Nil

// ### print
// `print(text x=0 y=0 color=15 fixed=false scale=1 smallfont=false) -> width`
// This will simply print text to the screen using the font defined in config.
// When set to true, the fixed width option ensures that each character will be printed in a `box` of the same size, so the character `i` will occupy the same width as the character `w` for example.
// When fixed width is false, there will be a single space between each character.

// Tips:
// - To use a custom rastered font, check out `font()`.
// - To print to the console, check out `trace()`.

pub fn print(text: anything, x: Int, y: Int) -> Nil {
  print_(string.inspect(text), x, y)
}

@external(javascript, "../tic_ffi.mjs", "print")
pub fn print_(text: String, x: Int, y: Int) -> Nil

// ### rect
// `rect(x y w h color)`
// This function draws a filled rectangle of the desired size and color at the specified position.
// If you only need to draw the the border or outline of a rectangle (ie not filled) see `rectb()`.

@external(javascript, "../tic_ffi.mjs", "rect")
pub fn rect(x: Int, y: Int, w: Int, h: Int, color: Int) -> Nil

// ### rectb
// `rectb(x y w h color)`
// This function draws a one pixel thick rectangle border at the position requested.
// If you need to fill the rectangle with a color, see `rect()` instead.

@external(javascript, "../tic_ffi.mjs", "rectb")
pub fn rectb(x: Int, y: Int, w: Int, h: Int, color: Int) -> Nil

// ### reset
// `reset()`
// Resets the cartridge. To return to the console, see the `exit()`.

@external(javascript, "../tic_ffi.mjs", "reset")
pub fn reset() -> Nil

// ### sfx
// `sfx(id note=-1 duration=-1 channel=0 volume=15 speed=0)`
// This function will play the sound with `id` created in the sfx editor.
// Calling the function with id set to -1 will stop playing the channel.
// The note can be supplied as an integer between 0 and 95 (representing 8 octaves of 12 notes each) or as a string giving the note name and octave.
// For example, a note value of `14` will play the note `D` in the second octave.
// The same note could be specified by the string `D-2`.
// Note names consist of two characters, the note itself (in upper case) followed by `-` to represent the natural note or `#` to represent a sharp.
// There is no option to indicate flat values.
// The available note names are therefore: C-, C#, D-, D#, E-, F-, F#, G-, G#, A-, A#, B-.
// The `octave` is specified using a single digit in the range 0 to 8.
// The `duration` specifies how many ticks to play the sound for since TIC-80 runs at 60 frames per second, a value of 30 represents half a second.
// A value of -1 will play the sound continuously.
// The `channel` parameter indicates which of the four channels to use. Allowed values are 0 to 3.
// The `volume` can be between 0 and 15.
// The `speed` in the range -4 to 3 can be specified and means how many `ticks+1` to play each step, so speed==0 means 1 tick per step.

pub fn sfx(id: Int) -> Nil {
  sfx_full(id, -1, -1, 0, 15, 0)
}

pub fn sfx_id_duration(id: Int, duration: Int) -> Nil {
  sfx_full(id, -1, duration, 0, 15, 0)
}

pub fn sfx_id_duration_channel(id: Int, duration: Int, channel: Int) -> Nil {
  sfx_full(id, -1, duration, channel, 15, 0)
}

pub fn sfx_full(
  id: Int,
  note: Int,
  duration: Int,
  channel: Int,
  volume: Int,
  speed: Int,
) -> Nil {
  sfx_(id, note, duration, channel, volume, speed)
}

@external(javascript, "../tic_ffi.mjs", "sfx")
fn sfx_(
  id: Int,
  note: Int,
  duration: Int,
  channel: Int,
  volume: Int,
  speed: Int,
) -> Nil

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

// ### sync
// `sync(mask=0 bank=0 tocart=false)`
// The pro version of TIC-80 contains 8 memory banks.
// To switch between these banks, sync can be used to either load contents from a memory bank to runtime, or save contents from the active runtime to a bank.
// The function can only be called once per frame.If you have manipulated the runtime memory (e.g. by using mset), you can reset the active state by calling sync(0,0,false).
// This resets the whole runtime memory to the contents of bank 0.Note that sync is not used to load code from banks; this is done automatically.

// ### time
// `time() -> ticks`
// This function returns the number of milliseconds elapsed since the cartridge began execution.
// Useful for keeping track of time, animating items and triggering events.

@external(javascript, "../tic_ffi.mjs", "time")
pub fn time() -> Int

// ### trace
// `trace(message color=15)`
// This is a service function, useful for debugging your code.
// It prints the message parameter to the console in the (optional) color specified.

pub fn trace(message: anything) -> Nil {
  trace(string.inspect(message), 15)
}

pub fn trace_clr(message: anything, color: Int) -> Nil {
  trace(string.inspect(message), color)
}

@external(javascript, "../tic_ffi.mjs", "trace")
fn trace_(message: String, color: Int) -> Nil
